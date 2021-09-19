import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/main.dart';

class BottomNavBar extends StatelessWidget {
  final int? index;
  final Function? setIndex;
  const BottomNavBar({
    Key? key, 
    @required this.index, 
    @required this.setIndex, 
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    BottomNavigationBarItem bottomNavBarItem({String? icon, String? label, bool? isSelected}){
    Color color = isSelected! ? Theme.of(context).accentColor:Colors.grey;
    return BottomNavigationBarItem(
      icon: Image.asset(icon!, color: color,height: 40.0,),
      label: label,
    );
  }

    return BottomNavigationBar(
      backgroundColor: Colors.white60,
      currentIndex: index!,
      onTap: (index){
        setIndex!(index);
      },
      items:[
        bottomNavBarItem(
          icon: 'icons/newspaper.png',
          label: AppLocalizations.of(navigatorKey.currentContext!).news,
          isSelected: index == 0
        ),
        bottomNavBarItem(
          icon: 'icons/contact.png',
          label: AppLocalizations.of(navigatorKey.currentContext!).contact_us,
          isSelected: index == 1
        ),
        bottomNavBarItem(
          icon: 'icons/album.png',
          label: AppLocalizations.of(navigatorKey.currentContext!).album,
          isSelected: index == 2
        ),
      ]
    );
  }
}