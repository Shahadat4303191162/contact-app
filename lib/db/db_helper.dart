import 'package:class11ddcontactapp/model/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static const String createTableContact='''
  create table $tableContact(
  $tableContactColId integer primary key,
  $tableContactColName text,
  $tableContactColNumber text,
  $tableContactColEmail text,
  $tableContactColAddress text,
  $tableContactColWebsite text,
  $tableContactColDob text,
  $tableContactColGender text,
  $tableContactColImage text,
  $tableContactColFav integer
  )
  ''';
  static Future<Database> open()async{

    final rootPath = await getDatabasesPath();      //database kothay install hobeoi tar path
    final dbPath = join(rootPath,'contact.db');     //ki nam e thakbe

    return openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute(createTableContact);
    });

  }
  static Future<int> insertContact(ContactModel contactModel) async{
    final db = await open();
    return db.insert(tableContact, contactModel.toMap());
  }

  static Future<List<ContactModel>> getAllContacts() async{
    final db = await open();
    final mapList = await db.query(tableContact, orderBy: tableContactColName);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  static Future<List<ContactModel>> getAllFavoriteContacts() async{
    final db = await open();
    final mapList = await db.query(
        tableContact,
        where: '$tableContactColFav=?',whereArgs:  [1],
        orderBy: tableContactColName);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  static Future<ContactModel> getContactByid(int id) async{
    final db = await open();
    final mapList = await db.query(
        tableContact,where: '$tableContactColId =?',whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);

  }
  static Future<int> updateFavorite(int id, int value) async{
    final db = await open();
    return db.update(tableContact, {tableContactColFav: value},
    where: '$tableContactColId = ?',whereArgs: [id]);
  }

  static Future<int> deleteContact(int id) async{
    final db = await open();
    return db.delete(tableContact, where: '$tableContactColId = ?',whereArgs: [id]);
  }

}