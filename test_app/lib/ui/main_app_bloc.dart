import 'package:rxdart/rxdart.dart';
import 'package:test_app/main.dart';
import 'package:test_app/ui/album/album_page.dart';
import 'package:test_app/ui/contact_us/contact_us_page.dart';
import 'package:test_app/ui/news/news_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainAppBloc {

  //index used for navigation in the main_app.dart
  BehaviorSubject<int> index = BehaviorSubject<int>();

  //used for the appbar title and body in the main_app.dart
  List<Map> pages = [
    {'title': AppLocalizations.of(navigatorKey.currentContext!).news, 'page': NewsPage()},
    {'title': AppLocalizations.of(navigatorKey.currentContext!).contact_us, 'page': ContactUsPage()},
    {'title': AppLocalizations.of(navigatorKey.currentContext!).album, 'page': AlbumPage()},
  ];

  void dispose(){
    index.close();
  }
}