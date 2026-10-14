import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'app/app.dart';
import 'app/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Apply workaround for Android/Huawei devices where libsqlite3.so fails to load
  if (Platform.isAndroid) {
    try {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    } catch (_) {}
  }

  // Initialize Clean Architecture dependency injection
  await initServiceLocator();

  runApp(const StoreeApp());
}
