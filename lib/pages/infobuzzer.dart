import 'package:flutter/material.dart';

class InfoBuzzerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Sensor Buzzer',
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
                'Sensor Buzzer',
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
                'Sensor  buzzer adalah aktuator yang menghasilkan suara berdasarkan frekuensi yang diberikan. Buzzer dapat menjadi output sebagai sinyal atau tanda dari mikrokontroler dan sensor.',
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
                child: Image.asset('assets/images/Buzzer.jpg'),
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
                'Pada dasarnya, prinsip kerja dari buzzer elektronika hampir sama dengan loud speaker dimana buzzer juga terdiri dari kumparan yang terpasang secara diafragma. Ketika kumparan tersebut dialiri listrik maka akan menjadi elektromagnet sehingga mengakibatkan kumparan tertarik ke dalam ataupun ke luar tergantung dari arah arus dan polaritas magnetnya. Karena kumparan dipasang secara diafragma maka setiap kumparan akan menggerakkan diafragma tersebut secara bolak-balik sehingga membuat udara bergetar yang akan menghasilkan suara. Namun dibandingkan dengan loud speaker, buzzer elektronika relatif lebih mudah untuk digerakkan. Sebagai contoh, buzzer elektronika dapat langsung diberikan tegangan listrik dengan taraf tertentu untuk dapat menghasilkan suara. Hal ini tentu berbeda dengan loud speaker yang memerlukan rangkaian penguat khusus untuk menggerakkan speaker agar menghasilkan suara yang dapat didengar oleh manusia.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
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
    home: InfoBuzzerPage(),
  ));
}
