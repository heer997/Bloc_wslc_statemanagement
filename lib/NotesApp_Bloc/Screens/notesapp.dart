import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Blocs/notes_bloc.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Blocs/notes_events.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Blocs/notes_states.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Database/dbhelper.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Screens/adddatascreen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotesBloc(dbHelper: DbHelper.dbHelper);
      },
      child: MaterialApp(
        title: "Notes App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            centerTitle: true,
          ),
        ),
        home: const NotesApp(),
      ),
    );
  }
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() {
    return NotesAppState();
  }
}

class NotesAppState extends State<NotesApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddDataScreen();
              },
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0),
      ),
      body: BlocBuilder<NotesBloc, NotesStates>(
        builder: (context, state) {
          if (state is NotesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesLoadedState) {
            return ListView.builder(
              itemCount: state.arrNotes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    title: Text(
                      state.arrNotes[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(state.arrNotes[index].desc),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<NotesBloc>().add(
                              NotesDeleteEvent(
                                  id: state.arrNotes[index].id!.toInt()),
                            );
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            );
          } else if (state is NotesErrorState) {
            return Center(
              child: Text(state.errormsg.toString()),
            );
          } else {
            return const Center(
              child: Text("No Data Found!!"),
            );
          }
        },
      ),
    );
  }
}
