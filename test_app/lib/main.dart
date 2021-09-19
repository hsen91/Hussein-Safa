import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/l10n/l10n.dart';
import 'package:test_app/main_bloc.dart';
import 'package:test_app/ui/main_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MainBloc _bloc = MainBloc(); 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
      stream: _bloc.locale,
      builder: (context, snapshot) {
        return MaterialApp(
          localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          locale: snapshot.data??L10n.all[0],
          title: 'Test App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorKey: navigatorKey,
          home: Container(
            color: Colors.green,
            child: Center(
              child: MainApp(
                mainBloc: _bloc,
              ),
            ),
          ),
        );
      }
    );
  }
}