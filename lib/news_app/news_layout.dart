import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:news/news_app/cubit/cubit.dart';
import 'package:news/news_app/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),
      child: BlocConsumer<NewsCubit ,NewsStates>(
        builder:(context, state)
        {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
              ),
              actions: [
                IconButton(
                  onPressed:(){
                    navigateTo(context, SearchScreen(),);
                  },
                    icon: Icon(
                      Icons.search,
                    ),
                ),
                IconButton(
                  onPressed:(){
                    NewsCubit.get(context).changeAppMode();
                  },
                  icon: Icon(
                    Icons.dark_mode,
                  ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItem,
            ),
          );
        },
        listener:(context, state) {

        },
      ),
    );
  }
}



