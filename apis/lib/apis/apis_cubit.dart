import 'package:apis/apis/api_states.dart';
import 'package:apis/apis/tech_Screen.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiCubit extends Cubit<ApisStates>{
  ApiCubit(ApisStates initialState) : super(initialState);

  static ApiCubit get (context) => BlocProvider.of(context);

  List<dynamic> articles = [];

  int position = 0;

  var title = [
    'Tech',
    'Sports',
    'Business',
  ];

  List<Widget> screen = [
    TechScreen(),
    TechScreen(),
    TechScreen(),
  ];


  void getHttp() async {
    try {
      var response = await Dio()
          .get('https://newsapi.org/v2/top-headlines', queryParameters: {
        'country': 'us',
        'category': 'technology',
        'apiKey': '79a9935c15874d60a2e59ea97e5b2e0f',
      });
      print("RESPONSE => $response");
      articles = response.data['articles'];
      emit(ApiImportState());

    } catch (e) {
      print("ERROR => $e");
    }
  }

  void sports() async {
    try {
      var response = await Dio()
          .get('https://newsapi.org/v2/top-headlines', queryParameters: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '79a9935c15874d60a2e59ea97e5b2e0f',
      });
      print("RESPONSE => $response");
      articles = response.data['articles'];
      emit(ApiImportSportsState());

    } catch (e) {
      print("ERROR => $e");
    }
  }

  void business() async {
    try {
      var response = await Dio()
          .get('https://newsapi.org/v2/top-headlines', queryParameters: {
        'country': 'us',
        'category': 'business',
        'apiKey': '79a9935c15874d60a2e59ea97e5b2e0f',
      });
      print("RESPONSE => $response");
      articles = response.data['articles'];
      emit(ApiImportBusinessState());

    } catch (e) {
      print("ERROR => $e");
    }
  }

  void onBottomNavigationChange(int value) {
    position = value;
    getHttp();
    sports();
    business();
    emit(ApiBottomNavigationBarState());
  }

  String tasksState = "active";

  void changeTaskState(String state){
    this.tasksState = state;
    getHttp();
    sports();
    business();
    emit(ApiChangeTasksState());
  }

}