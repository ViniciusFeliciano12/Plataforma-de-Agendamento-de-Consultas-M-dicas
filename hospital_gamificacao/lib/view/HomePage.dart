import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/recepcionista.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Recepcionista> recepcionistas;
  void fetchAlbum() {
    Completer<List<Recepcionista>> completer = Completer<List<Recepcionista>>();
    http
        .get(Uri.parse('http://localhost:5164/recepcionistas'))
        .then((response) {
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        recepcionistas =
            jsonResponse.map((data) => Recepcionista.fromJson(data)).toList();
        completer.complete(recepcionistas);
      } else {
        completer.completeError(Exception('Failed to load album'));
      }
    }).catchError((error) {
      completer.completeError(error);
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Página inicial do app de hospital.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchAlbum,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
