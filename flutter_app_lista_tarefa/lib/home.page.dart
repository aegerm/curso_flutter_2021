import 'package:flutter/material.dart';
import 'package:flutter_app_lista_tarefa/lista.tarefa.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListaTarefaPage(),
    );
  }
}
