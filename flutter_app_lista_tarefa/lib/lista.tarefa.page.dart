import 'package:flutter/material.dart';

class ListaTarefaPage extends StatefulWidget {
  const ListaTarefaPage({Key? key}) : super(key: key);

  @override
  _ListaTarefaPageState createState() => _ListaTarefaPageState();
}

class _ListaTarefaPageState extends State<ListaTarefaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
