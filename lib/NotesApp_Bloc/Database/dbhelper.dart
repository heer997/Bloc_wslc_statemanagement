import 'dart:io';
import 'package:bloc_wslc_statemanagement/NotesApp_Bloc/Models/noteModel.dart';
import "package:path/path.dart";
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper dbHelper = DbHelper();
  Database? database;
  static const Note_table = "notes";
  static const Note_id = "noteid";
  static const Note_title = "notetitle";
  static const Note_desc = "notedesc";

  Future<Database> getDb() async {
    if (database != null) {
      return database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbpath = join(directory.path + "notesdb2.db");
    return openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            "create table $Note_table ($Note_id integer primary key autoincrement,"
                " $Note_title text, $Note_desc text)");
      },
    );
  }

  Future<bool> addNotes(NotesModel newuser) async {
    var db = await getDb();
    int inserteddata = await db.insert(Note_table, newuser.toMap());
    return inserteddata > 0;
  }

  Future<List<NotesModel>> fetchData() async {
    var db = await getDb();
    List<Map<String, dynamic>> notes = await db.query(Note_table);
    List<NotesModel> listNotes = [];

    for (Map<String, dynamic> notesmodel in notes) {
      NotesModel newnote = NotesModel.fromMap(notesmodel);
      listNotes.add(newnote);
    }
    return listNotes;
  }

  Future<bool> DeleteNotes(int id) async {
    var db = await getDb();
    var count = await db.delete(Note_table, where: "$Note_id=?", whereArgs: [id.toString()]);
    return count > 0;
  }
}
