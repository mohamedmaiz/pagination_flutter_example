import 'package:flutter/material.dart';
import 'package:pagination_app/app/app.dart';
import 'package:pagination_app/core/di/dipendency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialApp();
  runApp(const MyApp());
}
