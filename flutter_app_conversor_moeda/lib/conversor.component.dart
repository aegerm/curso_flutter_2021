import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ConversorComponent extends StatefulWidget {
  const ConversorComponent({Key? key}) : super(key: key);

  @override
  _ConversorComponentState createState() => _ConversorComponentState();
}

class _ConversorComponentState extends State<ConversorComponent> {
  double dolar = 0.0;
  double euro = 0.0;

  final tfRealController = TextEditingController();
  final tfDolarController = TextEditingController();
  final tfEuroController = TextEditingController();

  void _realChanged(String text) {
    double real = double.parse(tfRealController.text);
    tfDolarController.text = (real / dolar).toStringAsFixed(2);
    tfEuroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    tfRealController.text = (dolar * this.dolar).toStringAsFixed(2);
    tfEuroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    tfRealController.text = (euro * this.euro).toStringAsFixed(2);
    tfDolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  Future<Map> getData() async {
    http.Response response = await http
        .get(Uri.parse('https://api.hgbrasil.com/finance?key=25af558b'));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          '\$Conversor\$',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (contex, snap) {
          switch (snap.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  'Carregando Dados...',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snap.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao carregar dados!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                  ),
                );
              } else {
                dolar = snap.data!["results"]["currencies"]["USD"]["buy"];
                euro = snap.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Colors.amber,
                      ),
                      buildTextField(
                          "Reais", "R\$", tfRealController, _realChanged),
                      const Divider(),
                      buildTextField(
                          "Dolares", "US\$", tfDolarController, _dolarChanged),
                      const Divider(),
                      buildTextField(
                          "Euros", "€", tfEuroController, _euroChanged)
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

buildTextField(String labelText, String prefix,
    TextEditingController controller, Function myFunction) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.amber),
        border: const OutlineInputBorder(),
        prefixText: prefix),
    style: const TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: (value) async {
      myFunction(value);
    },
    keyboardType: TextInputType.number,
  );
}
