import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Blocs/notes_events.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Blocs/notes_states.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Database/dbhelper.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class NotesBloc extends Bloc<NotesEvents, NotesStates> {
  DbHelper dbHelper;

  NotesBloc({required this.dbHelper}) : super(NotesInitialState()) {
    /// Add Data in Database
    on<NotesAddEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        bool check = await dbHelper.addNotes(event.newnote);
        if (check) {
          var arrnotes = await dbHelper.fetchData();
          emit(NotesLoadedState(arrNotes: arrnotes));
        } else {
          emit(NotesErrorState(errormsg: "An Error Occurred!"));
        }
      },
    );

    /// Get all Notes
    on<NotesFetchEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        var arrNotes = await dbHelper.fetchData();
        emit(NotesLoadedState(arrNotes: arrNotes));
      },
    );

    /// Delete Notes
    on<NotesDeleteEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        await dbHelper.DeleteNotes(event.id);
        var arrnotes = await dbHelper.fetchData();
        emit(NotesLoadedState(arrNotes: arrnotes));
      },
    );
  }
}
