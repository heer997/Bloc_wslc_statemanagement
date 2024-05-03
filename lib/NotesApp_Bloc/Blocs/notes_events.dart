import 'package:bloc_wslc_statemanagement/NotesApp_Bloc/Models/noteModel.dart';

abstract class NotesEvents {}

class NotesAddEvent extends NotesEvents {
  NotesModel newnote;

  NotesAddEvent({required this.newnote});
}

class NotesFetchEvent extends NotesEvents {}

class NotesDeleteEvent extends NotesEvents {
  int id;

  NotesDeleteEvent({required this.id});
}
