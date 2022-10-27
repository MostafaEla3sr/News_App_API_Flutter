import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/web_view/web_view_screen.dart';

Widget buildArticalItem (article , context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10.0,),
  
            image: DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}') ,
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                    fontSize: 18.0,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

Widget articleBuilder(list , context , {isSearch = false}) => ConditionalBuilder(
  condition: list.length>0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticalItem(list[index] , context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: 8,
  ),
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

void navigateTo(context , widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget,
    ),
);