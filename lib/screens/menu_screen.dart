import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glp/components/ppm_indicator.dart';
import 'package:glp/components/ppm_chart.dart'; // Import do gráfico
import 'package:glp/routes/app_routes.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  double ppmValue = 0;
  bool _pressedToken = false;
  late MqttServerClient client;

  @override
  void initState() {
    super.initState();
    _setupMqttClient();
  }

  Future<void> _setupMqttClient() async {
    client =
        MqttServerClient.withPort('broker.mqtt.cool', 'mqttx_6dfa6be4', 1883);
    client.keepAlivePeriod = 20;
    client.logging(on: true);
    client.setProtocolV311();
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;

    try {
      final connMess = MqttConnectMessage()
          .withClientIdentifier('mqttx_6dfa6be4')
          .withWillTopic('willtopic')
          .withWillMessage('My Will message')
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);
      debugPrint('Conectando ao broker...');
      client.connectionMessage = connMess;

      final MqttClientConnectionStatus? connectionStatus =
          await client.connect();
      if (connectionStatus?.state == MqttConnectionState.connected) {
        debugPrint('Conectado ao broker MQTT');
      } else {
        debugPrint('Falha ao conectar: ${connectionStatus?.state}');
        client.disconnect();
        return;
      }
    } catch (e) {
      debugPrint('Erro ao conectar: $e');
      client.disconnect();
      return;
    }

    if (client.updates != null) {
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        if (c != null && c.isNotEmpty) {
          final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
          final String payload =
              MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

          setState(() {
            ppmValue = double.parse(payload);
          });
        }
      });
    } else {
      debugPrint('Nenhuma atualização recebida.');
    }
  }

  void _onConnected() {
    debugPrint('Conectado ao broker MQTT');
    client.subscribe('sensor/ppm', MqttQos.atMostOnce);
  }

  void _onDisconnected() {
    debugPrint('Desconectado do broker MQTT');
  }

  void _onSubscribed(String topic) {
    debugPrint('Inscrito no tópico: $topic');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(AppRoutes.home),
                icon: Icon(
                  Icons.exit_to_app_rounded,
                  color: theme.onPrimary,
                ))
          ],
          centerTitle: true,
          backgroundColor: theme.primary,
          title: SvgPicture.asset(
            height: 36,
            'assets/images/logo_text_white.svg',
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Analisando Sensor',
                  style: TextStyle(fontSize: 18, color: theme.onSecondary),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _pressedToken = !_pressedToken;
                      });
                    },
                    child: Text(
                      _pressedToken ? '70D032AX' : '[TOKEN]',
                      style: TextStyle(color: theme.primary, fontSize: 18),
                    )),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PpmIndicator(ppm: ppmValue),
                const SizedBox(height: 20),
                SizedBox(
                  height: deviceSize.height * 0.3,
                  child: PpmChart(ppmValue: ppmValue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    client.disconnect(); // Desconecta ao sair
    super.dispose();
  }
}
