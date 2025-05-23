import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  final String? name;
  const UndefinedView({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route form $name is not defined'),
      ),
    );
  }
}
