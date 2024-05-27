import 'package:bloc_wslc_statemanagement/Api_handling_using_Bloc/Model/quote_model.dart';

class QuoteState {}

class QuoteInitialState extends QuoteState {}

class QuoteLoadingState extends QuoteState {}

class QuoteLoadedState extends QuoteState {
  DataModel resData;

  QuoteLoadedState({required this.resData});
}

class QuoteErrorState extends QuoteState {
  String errormsg;

  QuoteErrorState({required this.errormsg});
}
