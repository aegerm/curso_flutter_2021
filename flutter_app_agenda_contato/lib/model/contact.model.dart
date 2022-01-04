import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String idColumn = "idColumn";
const String nameColumn = "nameColumn";
const String emailColumn = "emailColumn";
const String phoneColumn = "phoneColumn";
const String imageColumn = "imageColumn";

class ContactModel {
  static final ContactModel _instance = ContactModel.internal();

  factory ContactModel() => _instance;

  ContactModel.internal();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE TbContact($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imageColumn TEXT)");
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database? dbContact = await database;
    contact.id = await dbContact?.insert("TbContact", contact.toMap());
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    Database? dbContact = await database;
    List<Map> maps = await dbContact!.query("TbContact",
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imageColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database? dbContact = await database;
    return dbContact!
        .delete("TbContact", where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database? dbContact = await database;
    return await dbContact!.update("TbContact", contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContact() async {
    Database? dbContact = await database;
    List maps = await dbContact!.rawQuery("SELECT * FROM TbContact");
    List<Contact> contacts = [];
    for (Map map in maps) {
      contacts.add(Contact.fromMap(map));
    }

    return contacts;
  }
}

class Contact {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;


  Contact();

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    image = map[imageColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imageColumn: image
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
