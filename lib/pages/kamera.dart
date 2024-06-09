import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Servo Control',
      home: KameraPage(),
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF12283D,
          <int, Color>{
            50: Color(0xFF12283D),
            100: Color(0xFF12283D),
            200: Color(0xFF12283D),
            300: Color(0xFF12283D),
            400: Color(0xFF12283D),
            500: Color(0xFF12283D),
            600: Color(0xFF12283D),
            700: Color(0xFF12283D),
            800: Color(0xFF12283D),
            900: Color(0xFF12283D),
          },
        ),
      ),
    );
  }
}

class KameraPage extends StatefulWidget {
  @override
  _KameraPageState createState() => _KameraPageState();
}

class _KameraPageState extends State<KameraPage> {
  late MqttServerClient client;
  double servoPosition = 90; // Initial position, can be changed as needed
  Uint8List? imageData;
  double temperature = 0;
  double humidity = 0;
  int numberOfPeople = 0;
  double estimation = 0;

  @override
  void initState() {
    super.initState();
    _setupMqtt();
  }

  void _setupMqtt() async {
    client =
        MqttServerClient.withPort('broker.hivemq.com', 'flutter_client', 1883);
    client.logging(on: true);

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .startClean()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
      print('MQTT client connected');
      client.subscribe('all-data', MqttQos.atLeastOnce);
      client.subscribe('image-topic', MqttQos.atLeastOnce);
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      if (c.isNotEmpty && c[0].payload is MqttPublishMessage) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        if (message.payload.message.isNotEmpty) {
          final String data = String.fromCharCodes(message.payload.message);

          if (c[0].topic == 'all-data') {
            try {
              handleAllData(data);
            } catch (e) {
              print('Error handling all data: $e');
            }
          } else if (c[0].topic == 'image-topic') {
            try {
              handleImageData(data);
            } catch (e) {
              print('Error handling image data: $e');
            }
          }
        }
      }
    });
  }

  void handleAllData(String data) {
    List<String> values = data.split(',');

    if (values.length >= 4) {
      setState(() {
        temperature = double.parse(values[0]);
        humidity = double.parse(values[1]);
        numberOfPeople = int.parse(values[2]);
        estimation = double.parse(values[3]);
      });
    } else {
      print('Error: Invalid all-data format');
    }
  }

  void handleImageData(String data) {
    final int commaIndex = data.indexOf(',');

    if (commaIndex != -1 && commaIndex < data.length - 1) {
      final String base64Data = data.substring(commaIndex + 1);

      setState(() {
        imageData = base64Decode(base64Data);
      });
    } else {
      print('Error: Invalid image data format');
    }
  }

  void _sendPosition(double position) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(position.round().toString());

    if (client?.connectionStatus?.state == MqttConnectionState.connected) {
      final payload = builder.payload;
      if (payload != null) {
        client.publishMessage('position-servo', MqttQos.atLeastOnce, payload);
        print('Position sent: $position');
      } else {
        print('Error: Payload is null');
      }
    } else {
      print('Error: MQTT client is not connected');
    }
  }

  void onConnected() {
    print('Connected');
  }

  void onDisconnected() {
    print('Disconnected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kamera',
          style: TextStyle(
            color: Color(0xFF12283D), // Change title text color
          ),
        ),
        backgroundColor: Colors.transparent, // Set to transparent
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xFF12283D), // Change icon color
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Adjust the padding as needed
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageData != null
                    ? Image.memory(imageData!, width: 300, height: 300)
                    : Text('No Image Data'),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _sendPosition(200);
                      },
                      child: Text('Kanan'),
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF12283D)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _sendPosition(380);
                      },
                      child: Text('Kiri'),
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF12283D)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Servo Position: ${servoPosition.round()}'),
                SizedBox(height: 20),
                Slider(
                  value: servoPosition,
                  min: 0,
                  max: 180,
                  onChanged: (value) {
                    setState(() {
                      servoPosition = value;
                    });
                  },
                  onChangeEnd: (value) {
                    _sendPosition(value);
                  },
                  activeColor: Color(0xFF12283D),
                  inactiveColor: Colors.grey,
                ),
                SizedBox(height: 20),
                // Display cards in rows of two
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildInfoCard(
                          icon: Icons.wb_sunny,
                          title: 'Temperature',
                          value: '${temperature.round()} °C',
                        ),
                      ),
                    ),
                    SizedBox(width: 16), // Adjust the spacing as needed
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildInfoCard(
                          icon: Icons.opacity,
                          title: 'Humidity',
                          value: '${humidity.round()} %',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildInfoCard(
                          icon: Icons.people,
                          title: 'Number of People',
                          value: '$numberOfPeople',
                        ),
                      ),
                    ),
                    SizedBox(width: 16), // Adjust the spacing as needed
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildInfoCard(
                          icon: Icons.assessment,
                          title: 'Estimation',
                          value: '${estimation.round()}',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon, required String title, required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 180,
        width: double.infinity, // Set width to fill available space
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF12283D),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF12283D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF12283D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    client.disconnect();
    print('MQTT client disconnected');
    super.dispose();
  }
}
