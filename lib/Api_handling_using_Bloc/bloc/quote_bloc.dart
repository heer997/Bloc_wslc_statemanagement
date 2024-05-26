import 'package:bloc_wslc_statemanagement/Api_handling_using_Bloc/Custom_Class/api_helper.dart';
import 'package:bloc_wslc_statemanagement/Api_handling_using_Bloc/Model/quote_model.dart';
import 'package:bloc_wslc_statemanagement/Api_handling_using_Bloc/Urls/urls.dart';
import 'package:bloc_wslc_statemanagement/Api_handling_using_Bloc/bloc/quote_event.dart';
import 'package:bloc_wslc_statemanagement/Api_handling_using_Bloc/bloc/quote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  ApiHelper apiHelper;

  QuoteBloc({required this.apiHelper}) : super(QuoteInitialState()) {
    on<QuoteEvent>(
      (event, emit) async {
        emit(QuoteLoadingState());

        var resJson = await apiHelper.getAPI(url: Urls.getQuotesUrl);

        if (resJson != null) {
          var mResData = DataModel.fromJson(resJson);
          emit(QuoteLoadedState(resData: mResData));
        } else {
          emit(QuoteErrorState(errormsg: "Uhh..No!!, Error Occurred"));
        }
      },
    );
  }
}
