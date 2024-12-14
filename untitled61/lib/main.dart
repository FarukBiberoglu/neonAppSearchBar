import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("İsim veya Soyisimle Arama")),
        body: SearchableTable(),
      ),
    );
  }
}

class SearchableTable extends StatefulWidget {
  @override
  _SearchableTableState createState() => _SearchableTableState();
}

class _SearchableTableState extends State<SearchableTable> {

  List<Map<String, String>> data = [
    {'name': 'Mini', 'surname': 'Mouse'},
    {'name': 'Mickey', 'surname': 'Mouse'},
    {'name': 'Donald', 'surname': 'Duck'},
    {'name': 'Goofy', 'surname': 'Goof'},
  ];

  List<Map<String, String>> filteredData = [];

  String searchQuery = '';
  String searchType = 'name';

  @override
  void initState() {
    super.initState();
    filteredData = List.from(data);
  }

  void filterData() {
    setState(() {
      filteredData = data
          .where((entry) =>
          entry[searchType]!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  searchType = 'name';
                });
                filterData();
              },
              child: Text("İsimle Ara"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  searchType = 'surname';
                });
                filterData();
              },
              child: Text("Soyisimle Ara"),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
              filterData();
            },
            decoration: InputDecoration(
              hintText: 'Arama yap...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('İsim')),
                DataColumn(label: Text('Soyisim')),
              ],
              rows: filteredData
                  .map((entry) => DataRow(cells: [
                DataCell(Text(entry['name']!)),
                DataCell(Text(entry['surname']!)),
              ]))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
