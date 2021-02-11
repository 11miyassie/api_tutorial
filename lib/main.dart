import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_tutorial/event_repository.dart';
import 'package:api_tutorial/connpass_repository.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connpass API App',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyApp(title: 'Connpassアプリ'),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<ConnpassRepository> futureConnpassRepository;

  Future<ConnpassRepository> fetchConnpassRepository() async {
    final response =
    await http.get('https://connpass.com/api/v1/event/?event_id=201351');
    print('${jsonDecode(response.body)['events'][0]['title']}');

    if (response.statusCode == 200) {
      return ConnpassRepository.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('失敗');
    }
  }

  @override
  void initState() {
    super.initState();
    futureConnpassRepository = fetchConnpassRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'api of connpass',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('イベント詳細'),
        ),
        body: Center(
          child: FutureBuilder<ConnpassRepository>(
            future: futureConnpassRepository,
            builder: (context, eventname) {
              if (eventname.hasData) {
                return Text('a');
              } else if (eventname.hasError) {
                return Text("${eventname.error}");
              }
              // ${jsonDecode(eventname.data.events)}
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
