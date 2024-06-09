import 'package:flutter/material.dart';
import 'package:smartsecurity/pages/dashboard.dart';
import 'package:smartsecurity/pages/datarfid.dart';
import 'package:smartsecurity/pages/grafiksuhu.dart';
import 'package:smartsecurity/pages/inforfid.dart';

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data',
          style: TextStyle(
            color: Color(0xFF12283D),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xFF12283D),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the dashboard page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataRFIDPage(),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
