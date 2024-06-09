import 'package:flutter/material.dart';

class InfoRFIDPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Sensor RFID',
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
                'Sensor RFID',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'RFID (Radio-Frequency Identification) adalah teknologi identifikasi otomatis yang menggunakan gelombang radio untuk mentransfer data antara label elektronik, atau tag RFID, dengan pembaca RFID melalui antena. Sensor RFID bekerja dengan membaca informasi yang disimpan pada tag RFID tanpa perlu kontak fisik.',
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
                child: Image.asset('assets/images/rfid.png'),
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
                'Sensor RFID bekerja dengan mengirimkan sinyal radio untuk mengaktifkan tag RFID yang ada di dekatnya. Setelah tag diaktifkan, tag akan mengirimkan informasi yang terkandung di dalamnya, seperti nomor seri atau data lainnya, kepada pembaca RFID. Teknologi ini umumnya digunakan untuk identifikasi, pelacakan barang atau orang, dan kontrol akses.',
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
    home: InfoRFIDPage(),
  ));
}
