import 'package:flutter/material.dart';

//CircularProgress class displays circular progress indicator or loader in app
class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(key: key),
    );
  }
}