import 'package:bloc_wslc_statemanagement/NotesApp_Bloc/Models/noteModel.dart';

abstract class NotesStates {}

class NotesInitialState extends NotesStates {}

class NotesLoadingState extends NotesStates {}

class NotesLoadedState extends NotesStates {
  List<NotesModel> arrNotes;

  NotesLoadedState({required this.arrNotes});
}

class NotesErrorState extends NotesStates {
  String errormsg;

  NotesErrorState({required this.errormsg});
}
