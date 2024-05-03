import "dart:developer";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Blocs/notes_bloc.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Blocs/notes_events.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Models/noteModel.dart";
import "package:bloc_wslc_statemanagement/NotesApp_Bloc/Widgets/uihelper.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() {
    return AddDataScreenState();
  }
}

class AddDataScreenState extends State<AddDataScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Data Screen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UiHelper.customTextFormField(
              titleController,
              "Enter the title",
              Icons.title,
            ),
            UiHelper.customTextFormField(
              descController,
              "Enter the description",
              Icons.description,
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                context.read<NotesBloc>().add(
                      NotesAddEvent(
                        newnote: NotesModel(
                          title: titleController.text.toString(),
                          desc: descController.text.toString(),
                        ),
                      ),
                    );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(350.0, 50.0),
                backgroundColor: Colors.blue,
                shape: const LinearBorder(),
              ),
              child: const Text(
                "Add Data",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
