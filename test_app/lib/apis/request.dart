import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/exceptions/errors.dart';
import 'package:test_app/exceptions/exceptions.dart';
import 'package:test_app/main.dart';

enum RequestType{
  GET,
  POST,
  PUT,
  DELETE
}
class Requests {
 
   Future request(
    {
      @required String? link,
      @required RequestType? requestType,
      Map? body,
    
    }
  ) async{

    _setHeader() => {
        'Content-Type': 'application/json',
        'Secret-Key': '\$2b\$10\$fKFxLhmrHrC7osKMZ6s1neeYHMBBguaSWR6tgRiseL8uPvwO1vtii'
      };
    
    try{
      http.Response response =
      requestType == RequestType.GET ? await http.get(
        Uri.parse(link!),
        headers: _setHeader(),
      )
      :
      requestType == RequestType.POST ? await http.post(
        Uri.parse(link!),
        body: body != null ? json.encode(body) : null,
        headers: _setHeader(),
      )
      :
      requestType == RequestType.DELETE ? await http.delete(
        Uri.parse(link!),
        headers: _setHeader(),
      )
      :
      await http.put(
        Uri.parse(link!),
        body: body != null ? json.encode(body) : null,
        headers: _setHeader(),
      );
      
      if(!navigatorKey.currentState!.mounted){
        return;
      }

      var result = jsonDecode(response.body);

      if(response.statusCode == 200){
        print('$requestType Succeeded');
        
        return result;
      }

      else{
        print(result);
        throw Exception('Something went wrong');
      }

    } on SocketException catch(e){
      ErrorMessage.error = "Please check your network connection";
      print(e);
      throw NoInternetException('No Internet');
    } on HttpException catch(e){
      ErrorMessage.error = "No Service Found";
      print(e);
      throw NoServiceFoundException('No Service Found');
    } on FormatException catch(e){
      ErrorMessage.error = "Invalid Data Format";
      print(e);
      throw InvalidFormatException('Invalid Data Format');
    } catch(e){
      ErrorMessage.error = "Something went wrong";
      print(e);
      throw UnknownException(e.toString());
    }
  }
}