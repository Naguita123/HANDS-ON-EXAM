import 'package:flutter/material.dart';
import '1.dart';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    title: "Hands on Exam",
    home: const Dashboard(),
  ));
}