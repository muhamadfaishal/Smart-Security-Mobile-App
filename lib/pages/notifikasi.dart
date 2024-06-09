import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NotifikasiPage(),
  ));
}

class NotifikasiPage extends StatelessWidget {
  final List<String> notifications = [
    'Terdeteksi 2 Orang',
    'Menggerakan servo ke kanan',
    'Menggerakan servo ke atas',
    // Tambahkan notifikasi lainnya sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style:
              TextStyle(color: Color(0xFF12283D)), // Mengubah warna teks title
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF12283D)), // Ubah warna tuisan
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20), // Jarak dari tepi body
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (BuildContext context, int index) {
              return buildNotificationItem(notifications[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget buildNotificationItem(String notification) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Stack(
            children: [
              Icon(Icons.notifications), // Icon notifikasi
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red, // Warna titik notifikasi
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                notification,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF12283D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
