import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_agenda_contato/contact.page.dart';
import 'package:flutter_app_agenda_contato/model/contact.model.dart';

class AgendaHome extends StatefulWidget {
  const AgendaHome({Key? key}) : super(key: key);

  @override
  _AgendaHomeState createState() => _AgendaHomeState();
}

class _AgendaHomeState extends State<AgendaHome> {
  ContactModel contactModel = ContactModel();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Contatos"),
        elevation: 0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contacts[index].image != null
                            ? FileImage(File(contacts[index].image!))
                            : const AssetImage("images/person.png")
                                as ImageProvider)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contacts[index].name ?? "",
                      style: const TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contacts[index].email ?? "",
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      contacts[index].phone ?? "",
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showContactPage(contact: contacts[index]);
      },
    );
  }

  void _showContactPage({Contact? contact}) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final readContact = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => ContactPage(contact)));

      if (readContact != null) {
        if (contact != null) {
          await contactModel.updateContact(contact);
        } else {
          await contactModel.saveContact(readContact);
        }
        _getAllContacts();
      }
    });
  }

  void _getAllContacts() {
    contactModel.getAllContact().then((list) {
      setState(() {
        contacts = list as List<Contact>;
      });
    });
  }
}
