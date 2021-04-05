import 'package:flutter/material.dart';
import 'package:my_app/app.dart';
import 'package:my_app/injectable_init.dart';

Future main() async {
  configureDependencies();
  runApp(MyApp());
}
