import 'package:flutter/material.dart';
import 'package:hospital_gamificacao/view/HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        toggleableActiveColor: Colors.blue, // Cor quando selecionado
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
