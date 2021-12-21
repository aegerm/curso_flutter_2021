import 'package:flutter/material.dart';
import 'package:flutter_app_calculadora_imc/imc.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      home: ImcPage(),
    );
  }
}
