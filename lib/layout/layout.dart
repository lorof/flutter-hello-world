import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    this.title = "Pizza list",
    this.child,
  }) : super(key: key);

  final String title;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: child);
  }
}
