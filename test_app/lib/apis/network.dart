import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Models/album.dart';
import 'package:test_app/Models/news.dart';
import 'package:test_app/apis/request.dart';
import 'package:test_app/apis/url.dart';
import 'package:test_app/main.dart';
import 'package:test_app/static_values/static_values.dart';
import 'package:test_app/styles/button_style.dart';
import 'package:test_app/styles/text_styles.dart';
class Network {
  
  static Future<Map<String,List<News>>> fetchNews() async{
    final response = await Requests().request(
      link: Url.fetchNews,
      requestType: RequestType.GET
    );
    print('Network/fetchNews: $response');
    Map<String,List<News>> result = {
      'English':[],
      'العربية': []
    };
    result['English'] = response['English'].map<News>((item)=>News.fromJson(item)).toList();
    result['العربية'] = response['Arabic'].map<News>((item)=>News.fromJson(item)).toList();
    return result;
  }

  static Future<List<Album>> fetchAlbum() async{
    final response = await Requests().request(
      link: Url.fetchAlbum,
      requestType: RequestType.GET
    );
    print('Network/fetchAlbum: $response');
    List<Album> result = response.map<Album>((item)=>Album.fromJson(item)).toList();
    return result;
  }

  static Future submitContact(data) async{
    final response = await Requests().request(
      link: Url.url,
      requestType: RequestType.POST,
      body: data
    );
    print('Network/submitContact: $response');
    return response['success'];
  }

  static Future createJsonMsg(data, String jsonType) async{
    final response = await Requests().request(
      link: Url.url,
      requestType: RequestType.POST,
      body: data
    );
    print('Network/createSuccessMsg: $response');
    jsonType == 'success' ? StaticValues.successJsonId = response['id']:StaticValues.failJsonId = response['id'];
    return response['success'];
  }

  // static Future createFailMsg(data) async{
  //   final response = await Requests().request(
  //     link: Url.url,
  //     requestType: RequestType.POST,
  //     body: data
  //   );
  //   print('Network/createFailMsg: $response');
  //   StaticValues.failJsonId = response['id'];
  //   return response['success'];
  // }
  
  static Future fetchMsg(String? id, GlobalKey<FormState> formKey) async{
    final response = await Requests().request(
      link: Url.url + '/$id',
      requestType: RequestType.GET
    );
    print('Network/fetchMsg: $response');

    return showDialog(
      context: navigatorKey.currentContext!, 
      builder: (context){
        return AlertDialog(
          title: Text('Message',style: TxtStyle.titleStyle,),
          content: Text(
            response['message']
          ),
          actions: [
            MaterialButton(
              color: Colors.redAccent,
              child:Text('Close',style: BtnStyle.whiteTxtBtn,),
              onPressed: (){
                response['code'] == 1 ? formKey.currentState!.reset():null;
                Navigator.of(context).pop();
              }
            )
          ],
        );
      }
    );
    
    //return result;
  }
}