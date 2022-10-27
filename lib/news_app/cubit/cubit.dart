import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/news_app/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';

import '../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(
            Icons.business
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.sports
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.science
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    if (index == 1){
      getSports();
    }
    if (index == 2){
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:{
        'country' : 'eg',
        'category' : 'business',
        'apikey' : 'ff942302e838446ba58edb4b05aa1b99',
      } ,
    ).then((value)
    {
      business = value.data['articles'];
      print(business[0]['title']);
      
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country' : 'eg',
          'category' : 'sports',
          'apikey' : 'ff942302e838446ba58edb4b05aa1b99',
        } ,
      ).then((value)
      {
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country' : 'eg',
          'category' : 'science',
          'apikey' : 'ff942302e838446ba58edb4b05aa1b99',
        } ,
      ).then((value)
      {
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else {
      emit(NewsGetScienceSuccessState());
    }

  }


  List<dynamic> search = [];

  void getSearch(String value)
  {

    DioHelper.getData(
        url: 'v2/everything',
        query:{
          'q' : '$value',
          'apikey' : 'ff942302e838446ba58edb4b05aa1b99',
        } ,
      ).then((value)
      {
        search = value.data['articles'];
        print(search[0]['title']);

        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
  }


  bool isDark = false;


  void changeAppMode({bool? fromShared})
  {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsAppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper().putBoolean(key:'isDark' , value: isDark).then((value)
      {
        emit(NewsAppChangeModeState());
      });
    }

  }

}

