import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smartsecurity/pages/datarfid.dart';
import 'package:smartsecurity/pages/infobuzzer.dart';
import 'package:smartsecurity/pages/infopir.dart';
import 'package:smartsecurity/pages/inforfid.dart';
import 'package:smartsecurity/pages/login.dart';
import 'package:smartsecurity/pages/notifikasi.dart';
import 'data.dart';
import 'infoalat.dart';
import 'profile.dart';
import 'grafiksuhu.dart';
import 'kamera.dart';
import 'grafikorang.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late MqttServerClient client;
  String temperature = '0';
  String humidity = '0';

  @override
  void initState() {
    super.initState();
    connectMQTT();
  }

  void connectMQTT() async {
    client =
        MqttServerClient.withPort('broker.hivemq.com', 'flutter_client', 1883);
    client.logging(on: true);

    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribeFail = onSubscribeFail;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .startClean()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
      client.subscribe('all-data', MqttQos.exactlyOnce);
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    void _updateDashboardData(String temperature, String humidity) {
      setState(() {
        this.temperature = temperature;
        this.humidity = humidity;
      });
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      if (c.isNotEmpty && c[0].payload is MqttPublishMessage) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        if (message.payload.message.isNotEmpty) {
          final String data = String.fromCharCodes(message.payload.message);

          if (c[0].topic == 'all-data') {
            final List<String> values = data.split(',');

            if (values.length == 4) {
              final String receivedTemperature = values[0];
              final String receivedHumidity = values[1];

              // Update the data and trigger a rebuild
              _updateDashboardData(receivedTemperature, receivedHumidity);
            }
          }
        }
      }
    });
  }

  void onConnected() {
    print('Connected');
  }

  void onSubscribed(String topic) {
    print('Subscribed $topic');
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onUnsubscribed(String? topic) {
    print('Unsubscribed $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  int _currentIndex = 0;
  List<Widget> get _pages {
    return [
      DashboardContent(temperature: temperature, humidity: humidity),
      DataPage(),
      InfoAlatPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF12283D),
        unselectedItemColor: Colors.grey, // Color for unselected items
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Info Alat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  final String temperature;
  final String humidity;

  DashboardContent({required this.temperature, required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              // Widget foto profil dan teks
              GestureDetector(
                onTap: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(0, 130, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    items: [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Profile'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey,
                            child: Image.asset(
                              'assets/images/saya.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Home',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8D8D8D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Muhamad Faishal', // Ganti dengan nama pengguna
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF12283D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotifikasiPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              Text(
                'Sensor', // Ganti dengan nama pengguna
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF12283D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => KameraPage()),
                        );
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Padding(
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
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Camera',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF12283D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Aktif',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF12283D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Color(0xFF12283D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DataRFIDPage()),
                        );
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Padding(
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
                                      Icons.settings_remote,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'RFID',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF12283D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Aktif',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF12283D),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Color(0xFF12283D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Padding(
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
                                    Icons
                                        .ac_unit, // Ganti dengan ikon yang sesuai untuk suhu
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Suhu',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF12283D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        5), // Spasi antara teks "Suhu" dan temperatur
                                Text(
                                  '${temperature} °C',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF12283D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Padding(
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
                                    Icons
                                        .wb_sunny, // Ganti dengan ikon yang sesuai untuk kelembaban
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Kelembaban',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF12283D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        5), // Spasi antara teks "Suhu" dan temperatur
                                Text(
                                  '${humidity} %',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF12283D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Grafik Suhu', // Ganti dengan nama pengguna
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF12283D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    GrafikSuhuPage(), // Menampilkan widget grafik di dalam Container ini
              ),
              SizedBox(height: 30),
              Text(
                'Grafik Jumlah Orang', // Ganti dengan nama pengguna
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF12283D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    GrafikOrangPage(), // Menampilkan widget grafik di dalam Container ini
              ),
            ],
          ),
        ),
      ),
    );
  }
}
