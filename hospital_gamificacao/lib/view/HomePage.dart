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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hospital gamificação"),
      ),
      body: Column(
        children: <Widget>[
          const TopNavigationBar(selectedIndex: 1),
        ],
      ),
    );
  }
}
