import 'package:bloc_wslc_statemanagement/NotesApp_Bloc/Database/dbhelper.dart';

class NotesModel {
  int? id;
  String title;
  String desc;

  NotesModel({this.id, required this.title, required this.desc});

  /// When data will go(data will Add) in database at that time, we will use toMap() function(toMap -> insert)
  /// When data will fetch from database at that time, we will use fromMap() function(fromMap -> fetch)
  /// When we work with API, at that time, we will use toJson() and fromJson() method

  /// Use of "factory" keyword : When data will go in database and when data will fetch from database,
  /// at that time small amount of data will be stored in "factory" keyword.

  /// To get data(fetch data) from database, fromMap() method is used as shown below:
  factory NotesModel.fromMap(Map<String, dynamic> mapdata) {
    return NotesModel(
        id: mapdata[DbHelper.Note_id],
        title: mapdata[DbHelper.Note_title],
        desc: mapdata[DbHelper.Note_desc]);
  }

  /// To Add data(store data) in database, toMap() method is used as shown below:
  Map<String, dynamic> toMap() {
    return {
      DbHelper.Note_id: id,
      DbHelper.Note_title: title,
      DbHelper.Note_desc: desc,
    };
  }
}
