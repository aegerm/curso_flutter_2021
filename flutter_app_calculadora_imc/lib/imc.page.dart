import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  _ImcPageState createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final tfPesoController = TextEditingController();
  final tfAlturaController = TextEditingController();

  String informacao = "";
  double peso = 0;
  double altura = 0;

  void _resetFields() {
    setState(() {
      tfPesoController.text = "";
      tfAlturaController.text = "";
      informacao = "Informação";
    });
  }

  void calcularImc() {
    setState(() {
      peso = double.parse(tfPesoController.text);
      altura = double.parse(tfAlturaController.text) / 100;

      double resultado = peso / (altura * altura);

      if (resultado < 18.5) {
        informacao = "MAGREZA";
      } else if (resultado >= 18.5 && resultado <= 24.9) {
        informacao = "NORMAL";
      } else if (resultado >= 25.0 && resultado >= 29.9) {
        informacao = "SOBREPESO";
      } else if (resultado >= 30.0 && resultado <= 39.9) {
        informacao = "OBESIDADE";
      } else if (resultado > 40.0) {
        informacao = "OBESIDADE GRAVE";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: tfPesoController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Insira o valor do Peso";
                  }
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text(
                  "Peso (Kg)",
                  style: TextStyle(color: Colors.green),
                )),
              ),
              TextFormField(
                controller: tfAlturaController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Insira o valor de Altura";
                  }
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text(
                  "Altura (cm)",
                  style: TextStyle(color: Colors.green),
                )),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    calcularImc();
                  }
                },
                child: const Text("Calcular"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                informacao,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}
