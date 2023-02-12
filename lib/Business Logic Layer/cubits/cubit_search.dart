import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data layer/Models/search_model.dart';
import '../../presentation%20layer/constants/constants.dart';

import '../../Data layer/dio_helper.dart';

import '../states/state_search.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitState());

  static SearchCubit getObject(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String? text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: 'products/search', token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Error search ${error.toString()}');
      }

      emit(SearchErrorState());
    });
  }
}
