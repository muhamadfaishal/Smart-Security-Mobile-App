import 'package:flutter/material.dart';

class InfoESP32CamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi ESP32 Cam',
          style:
              TextStyle(color: Color(0xFF12283D)), // Mengubah warna teks title
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF12283D)), // Ubah warna tuisan
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0), // Padding keseluruhan dari sisi body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 8.0), // Padding antara elemen
              child: Text(
                'ESP32 Cam',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 8.0), // Padding antara elemen
              child: Text(
                'ESP32-CAM merupakan salah satu mikrokontroler yang dilengkapi dengan internal kamera 2MP,  kartu microSD dan perlengkapan untuk menggunakan antena eksternal. Modul ESP32-CAM juga dilengkapi dengan dukungan library untuk mengimplementasikan kemampuan face recognition. Semua fitur ini masih memiliki akses ke beberapa pin GPIO, WiFi dan kemampuan Bluetooth. Jika dibandingkan dengan ESP produk sebelumnya yaitu ESP32 Wroom, ESP32-CAM memiliki I/O yang lebih sedikit dengan hanya memiliki akses ke 10 pin GPIO. Hal ini dikarenakan sudah banyak pin yang digunakan secara internal untuk fungsi kamera dan fungsi slot kartu microSD.',
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
                child: Image.asset('assets/images/esp32cam.jpg'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 8.0), // Padding antara elemen
              child: Text(
                'Cara Kerja',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 8.0), // Padding antara elemen
              child: Text(
                'Adapun spesifikasi ESP32-CAM antara lain :',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Text(
              '1. Memiliki 520 KB SRAM dan 4 MB os PSRAM',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '2. Mendukung upload gambar WiFi LED Flash Built In',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '3. Sistem kamera dapat diupgrade In-Built Micro SD Card slot',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '4. Image transfer rate 15 hingga 60 frame per detik',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '5. Konektor antena eksternal untuk rentang yang ditingkatkan',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '6. Dukungan bawaan untuk IwIP dan FreeRTOS pendaftaran wajah dan dukungan pengenalan wajah',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
            // ...Tambahkan padding untuk informasi lainnya...
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InfoESP32CamPage(),
  ));
}
