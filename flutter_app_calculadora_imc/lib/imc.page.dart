import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  _ImcPageState createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                label: Text(
              "Peso (Kg)",
              style: TextStyle(color: Colors.green),
            )),
          ),
        ],
      ),
    );
  }
}
