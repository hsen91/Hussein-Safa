import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Models/news.dart';
import 'package:test_app/styles/text_styles.dart';

class DetailsPage extends StatelessWidget {
  final News? news;
  const DetailsPage({ Key? key, @required this.news }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0,),
              Text(news!.title!, style: TxtStyle.titleStyle,),
              Text(news!.date!, style: TxtStyle.dateStyle,),
              SizedBox(height: 20.0,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  imageUrl: news!.image!,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 40.0,),
              Text(news!.text!),
            ],
          ),
        ),
      ),
      
    );
  }
}