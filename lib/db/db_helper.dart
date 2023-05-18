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
}