import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Clean Architecture dependency injection
  await initServiceLocator();

  runApp(const StoreeApp());
}
