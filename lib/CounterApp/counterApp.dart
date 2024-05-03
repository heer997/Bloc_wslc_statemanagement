import "package:bloc_wslc_statemanagement/CounterApp/Blocs/counterbloc.dart";
import "package:bloc_wslc_statemanagement/CounterApp/Blocs/counterevents.dart";
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
        return CounterBloc();
      },
      child: MaterialApp(
        title: "Counter App using Bloc",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            centerTitle: true,
          ),
        ),
        home: const CounterAppBloc(),
      ),
    );
  }
}

class CounterAppBloc extends StatefulWidget {
  const CounterAppBloc({super.key});

  @override
  State<CounterAppBloc> createState() {
    return CounterAppBlocState();
  }
}

class CounterAppBlocState extends State<CounterAppBloc> {
  @override
  Widget build(BuildContext context) {
    print("Build Method Called...");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Counter App using Bloc",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(IncrementEvent());
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 20.0),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(DecrementEvent());
            },
            backgroundColor: Colors.brown,
            child: const Icon(Icons.remove, color: Colors.white, size: 30.0),
          ),
        ],
      ),
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, state) {
          print("Builder...");
          return Center(
            child: Text(
              state.toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
            ),
          );
        },
      ),
    );
  }
}
