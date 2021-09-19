import 'package:flutter/material.dart';
import 'package:test_app/l10n/l10n.dart';
import 'package:test_app/main_bloc.dart';
import 'package:test_app/ui/news/news_bloc.dart';

class LanguageDropDown extends StatelessWidget {
  MainBloc? bloc;

  LanguageDropDown({
    Key? key,
    @required this.bloc,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: locale,
        icon: Container(width: 12),
        items: L10n.all.map(
          (locale) {
            final flag = L10n.getFlag(locale.languageCode);
            return DropdownMenuItem(
              child: Center(
                child: Text(
                  flag,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              value: locale,
              onTap: () {
                bloc!.locale.add(locale);       
              },
            );
          },
        ).toList(),
        onChanged: (_) {},
      ),
    );
  }
}