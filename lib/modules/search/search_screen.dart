import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news_app/cubit/cubit.dart';
import 'package:news/news_app/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
       listener: (context, state) {

       },
      builder: (context, state) {
         var list = NewsCubit.get(context).search;
         return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: articleBuilder(list, context , isSearch: true,)),
            ],
          ),
        );
      },
    );
  }
}
