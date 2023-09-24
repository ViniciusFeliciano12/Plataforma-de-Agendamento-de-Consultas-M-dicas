import 'package:flutter/material.dart';
import 'package:hospital_gamificacao/myApp.dart';
import 'package:hospital_gamificacao/services/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}
