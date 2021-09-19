import 'package:flutter/material.dart';
import 'package:test_app/main_bloc.dart';
import 'package:test_app/ui/main_app_bloc.dart';
import 'package:test_app/ui/news/news_bloc.dart';
import 'package:test_app/widgets/bottom_nav_bar.dart';
import 'package:test_app/widgets/language_dropdown.dart';

// ignore: must_be_immutable
class MainApp extends StatelessWidget {
  MainBloc? mainBloc;
  MainApp({
    Key? key,
    @required this.mainBloc
  }):super(key: key);
  
  int? _index = 0;
  
  @override
  Widget build(BuildContext context) {
    final MainAppBloc _bloc = MainAppBloc();
    final NewsBloc _newsBloc = NewsBloc();
    return StreamBuilder<int>(
      stream: _bloc.index,
      builder: (context, snapshot) {
        if(snapshot.data != null && snapshot.hasData){
          _index = snapshot.data;
        }

        setIndex(int newIndex){
          _bloc.index.add(newIndex);
        }

        return Scaffold(
          
          appBar: AppBar(
            title: Text(_bloc.pages[_index!]['title']),
            actions: [
              LanguageDropDown(
                bloc: mainBloc,
              ),
              SizedBox(width: 12),
            ],
          ),

          body: _bloc.pages[_index!]['page'],

          bottomNavigationBar: BottomNavBar(
            index: snapshot.data??0,
            setIndex: setIndex,
          )
        );
      }
    );
  }
}