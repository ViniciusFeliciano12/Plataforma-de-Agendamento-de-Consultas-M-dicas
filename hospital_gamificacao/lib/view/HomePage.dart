import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_gamificacao/services/interfaces/ihospital_api.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';
import 'package:hospital_gamificacao/view/top_navigation_bar.dart';
import 'package:http/http.dart' as http;

import '../models/recepcionista.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Recepcionista> recepcionistas = [];

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        TopNavigationBar(selectedIndex: 1),
        SizedBox(height: 10),
        Center(
          child: Text(
            "Dashboard",
            style: TextStyle(fontSize: 70),
          ),
        ),
        Text("Médico mais requisitado:")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hospital gamificação"),
      ),
      body: _body(),
    );
  }
}
