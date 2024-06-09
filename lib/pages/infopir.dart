import 'package:flutter/material.dart';

class InfoDHT11Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Sensor DHT11',
          style: TextStyle(color: Color(0xFF12283D)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF12283D)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Sensor DHT11',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Sensor DHT11 adalah sensor suhu dan kelembaban yang sering digunakan dalam berbagai proyek elektronika. Sensor ini memiliki kemampuan untuk mengukur suhu dalam rentang -20°C hingga 50°C dengan ketelitian sekitar ±2°C, serta dapat mengukur kelembaban dalam rentang 20% hingga 80% dengan ketelitian sekitar ±5%. Sensor DHT11 memiliki dua output data, yang satu untuk suhu dan yang lainnya untuk kelembaban.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(20.0),
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Image.asset('assets/images/dht11.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Cara Kerja',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Sensor DHT11 menggunakan termistor untuk mengukur suhu dan sensor kelembaban untuk mengukur tingkat kelembaban udara. Termistor berubah resistansinya tergantung pada suhu, sedangkan sensor kelembaban mengukur perubahan resistansi terkait dengan kelembaban udara. Sensor ini memiliki sinyal keluaran digital yang dapat dibaca oleh mikrokontroler atau platform lainnya.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InfoDHT11Page(),
  ));
}
