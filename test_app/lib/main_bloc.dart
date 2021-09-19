import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_app/l10n/l10n.dart';

class MainBloc{

  // To change the application language 
  BehaviorSubject<Locale> locale = BehaviorSubject<Locale>.seeded(L10n.all[0]);

  void dispose(){
    locale.close();
  } 
}