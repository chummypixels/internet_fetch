import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse;
  List listResponse;
  Map mapResponse;
  List listOfFacts;

  Future fetchData() async {
    http.Response response;
    response =
        await http.get('https://www.thegrowingdeveloper.org/apiview?id=2');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listOfFacts = mapResponse['facts'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch data from the internet'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            mapResponse == null
                ? Container()
                : Text(
                    mapResponse['category'].toString(),
                  ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Image.network(
                        listOfFacts[index]['image_url'],
                      ),
                      Text(
                        listOfFacts[index]['title'].toString(),
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
              itemCount: listOfFacts == null ? 0 : listOfFacts.length,
            )
          ],
        ),
      ),
    );
  }
}
