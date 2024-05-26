import "package:bloc_wslc_statemanagement/Api_handling_using_Bloc/Custom_Class/api_helper.dart";
import "package:bloc_wslc_statemanagement/Api_handling_using_Bloc/bloc/quote_bloc.dart";
import "package:bloc_wslc_statemanagement/Api_handling_using_Bloc/bloc/quote_event.dart";
import "package:bloc_wslc_statemanagement/Api_handling_using_Bloc/bloc/quote_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
      ),
      home: BlocProvider(
        create: (context) {
          return QuoteBloc(apiHelper: ApiHelper());
        },
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuoteBloc>(context).add(GetQuotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quotes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state is QuoteLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuoteErrorState) {
            return Center(
              child: Text(state.errormsg),
            );
          } else if (state is QuoteLoadedState) {
            var mDataModel = state.resData;

            return ListView.builder(
              itemCount: mDataModel.quotes?.length,
              itemBuilder: (context, index) {
                var eachQuote = mDataModel.quotes![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7.0,
                    child: ListTile(
                      title: Text("${eachQuote.quote}"),
                      subtitle: Text("${eachQuote.author}"),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
