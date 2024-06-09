import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:smartsecurity/pages/dashboard.dart';

void main() {
  runApp(MaterialApp(
    home: DataRFIDPage(),
  ));
}

class DataRFIDPage extends StatefulWidget {
  @override
  _DataRFIDPageState createState() => _DataRFIDPageState();
}

class _DataRFIDPageState extends State<DataRFIDPage> {
  List<Map<String, dynamic>> _tableData = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromAPI();
  }

  Future<void> _fetchDataFromAPI() async {
    final response =
        await http.get(Uri.parse('http://192.168.43.23:8000/api/rfid'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> fetchedData = json.decode(response.body);

      setState(() {
        final List<dynamic> rfidData = fetchedData['rfid_data'];

        for (var i = 0; i < rfidData.length; i++) {
          final Map<String, dynamic> data = rfidData[i];
          _tableData.add({
            'No': _tableData.length + 1,
            'UID': data['uid'],
            'Tanggal': data['created_at'],
          });
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data RFID',
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data RFID',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF12283D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text('No'),
                      ),
                      DataColumn(
                        label: Text('UID'),
                      ),
                      DataColumn(
                        label: Text('Created At'),
                      ),
                    ],
                    rows: _tableData.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(
                              Text((_tableData.indexOf(data) + 1).toString())),
                          DataCell(
                            Text(data['UID'].toString()),
                          ),
                          DataCell(
                            Text(data['Tanggal'].toString()),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
