import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_app/apis/network.dart';
import 'package:test_app/static_values/static_values.dart';


class ContactUsBloc {

  // disable send button before creating a success and fail json
  BehaviorSubject<bool> enabled = BehaviorSubject<bool>.seeded(false);

  //for enabling and disabling the create json buttons when sending an http request
  BehaviorSubject<bool> jsonButtons = BehaviorSubject<bool>.seeded(true);

  //becomes true after creating a success json
  bool successJson = false;

  //becomes true after creating a fail json
  bool failJson = false;

 //Validate the form in contact_us_page
  validator(key){
    if(key.currentState != null && key.currentState!.validate()){
      key.currentState!.save();
      
      return true;
    }
    else{
      return false;
    }
  }

  //send data received from contact_us_page
  sendMessage(GlobalKey<FormState> key, Map contactData) async {
    bool success = await Network.submitContact(contactData);
    print('SSSSSS: $success');
    await Network.fetchMsg(success ? StaticValues.successJsonId:StaticValues.failJsonId, key);
    
    enabled.add(true);
  }

  // Create a success and fail json file in jsonbin.io
  createJson(Map data,String text) async{
    jsonButtons.add(false);
    bool created;
    if(text == 'success'){
      created = await Network.createJsonMsg(data,'success');
      successJson = created ? true: false;
    }
    else{
      created = await Network.createJsonMsg(data,'fail');
      failJson = created ? true: false;
    }
    jsonButtons.add(true);
    if(successJson && failJson){
      enabled.add(true);
    }
    return created;
  }

  // show toast message after pressing the create success and fail msg buttons
  showSnackBar(String text){
    return SnackBar(
      content: Text(text),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {
        },
      ),
    );
  }

  void dispose(){
    enabled.close();
    jsonButtons.close();
  }
}


