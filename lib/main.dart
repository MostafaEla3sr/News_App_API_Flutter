import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/news_app/cubit/cubit.dart';
import 'package:news/news_app/cubit/states.dart';
import 'package:news/news_app/news_layout.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';


void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  if(isDark == null){
    isDark = false;
  }

  runApp(MyApp(isDark!));
}


class MyApp extends StatelessWidget{

  final bool isDark;

  MyApp(this.isDark);


  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create:(context) =>  NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (BuildContext context) => NewsCubit()..changeAppMode(fromShared: isDark,),),
      ],
        
        child: BlocConsumer< NewsCubit , NewsStates>(
          builder: (context, state) {
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: HexColor('333739'),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
              home: NewsLayout(),
            );
          },
          listener: (context, state) {

          },
        ),
      );
  }

}