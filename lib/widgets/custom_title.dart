
import 'package:flutter/material.dart';


class CustomTitle extends StatelessWidget {

  final String title;


  CustomTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Text(title, style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
