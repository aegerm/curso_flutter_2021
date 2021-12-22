import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListaTarefaPage extends StatefulWidget {
  const ListaTarefaPage({Key? key}) : super(key: key);

  @override
  _ListaTarefaPageState createState() => _ListaTarefaPageState();
}

class _ListaTarefaPageState extends State<ListaTarefaPage> {
  List _toDoList = [];
  final taskController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData().then((value) {
      setState(() {
        _toDoList = json.decode(value!);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> addItem = {};
      addItem["title"] = taskController.text;
      taskController.text = "";
      addItem["ok"] = false;
      _toDoList.add(addItem);
      saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: taskController,
                  decoration: const InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent)),
                )),
                ElevatedButton(
                  onPressed: _addToDo,
                  child: const Text("ADD"),
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: builderItem))
        ],
      ),
    );
  }

  CheckboxListTile builderItem(context, index) {
    return CheckboxListTile(
      title: Text(_toDoList[index]["title"]),
      value: _toDoList[index]["ok"],
      secondary: CircleAvatar(
        child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
      ),
      onChanged: (bool? value) {
        setState(() {
          _toDoList[index]["ok"] = value;
          saveData();
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> _getData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (ex) {
      return null;
    }
  }
}
