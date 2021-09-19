import 'package:flutter/material.dart';
import 'package:test_app/Models/news.dart';
import 'package:test_app/exceptions/errors.dart';
import 'package:test_app/styles/text_styles.dart';
import 'package:test_app/ui/news/details_page.dart';
import 'package:test_app/ui/news/news_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsPage extends StatelessWidget {
  NewsPage({ Key? key }) : super(key: key);
  final NewsBloc bloc = NewsBloc();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String,List<News>>>(
      stream: bloc.news$,
      builder: (context, snapshot) {
        if(snapshot.data != null && snapshot.hasData){
          List<News>? news = snapshot.data![AppLocalizations.of(context).language];
          return ListView.builder(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: news!.length,
            itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context)=>DetailsPage(news: news[index])
                        )
                      );
                    },
                    leading: 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        width: 50.0,
                        imageUrl: news[index].image!,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      // Image(
                      //   width: 50.0,
                      //   image: NetworkImage(
                      //     news[index].image!
                      //   ),
                      // ),
                    ),
                    title: centerTxt(news[index].title, TxtStyle.titleStyle),
                    
                    subtitle: centerTxt(news[index].date, TxtStyle.dateStyle)
                    
                  ),
                ),
              );
            },
          );
        }
        if(snapshot.hasError){
          return Center(
            child: Text(ErrorMessage.error),
          );
        }

        return Center(
          child: LinearProgressIndicator(),
        );
      }
    );
  }
}

Center centerTxt(String? text,TextStyle? style){
  return Center(
    child:Text(text!,style:style)
  );
}