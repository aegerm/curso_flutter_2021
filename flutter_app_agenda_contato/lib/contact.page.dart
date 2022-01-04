import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_agenda_contato/model/contact.model.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  const ContactPage(this.contact, {Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late Contact _updateContact;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _userUpdated = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _updateContact = Contact();
    } else {
      _updateContact = Contact.fromMap(widget.contact!.toMap());
      _nameController.text = _updateContact.name!;
      _emailController.text = _updateContact.email!;
      _phoneController.text = _updateContact.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(_updateContact.name ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _updateContact);
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _updateContact.image != null
                            ? FileImage(File(_updateContact.image!))
                            : const AssetImage("images/person.png")
                                as ImageProvider)),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(label: Text("Nome")),
              onChanged: (text) {
                _userUpdated = true;
                setState(() {
                  _updateContact.name = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(label: Text("Email")),
              onChanged: (text) {
                _userUpdated = true;
                _updateContact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(label: Text("Phone")),
              onChanged: (text) {
                _userUpdated = true;
                _updateContact.phone = text;
              },
              keyboardType: TextInputType.phone,
            )
          ],
        ),
      ),
    );
  }
}
