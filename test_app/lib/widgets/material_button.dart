import 'package:flutter/material.dart';
import 'package:test_app/styles/button_style.dart';

class MaterialBtn extends StatelessWidget {
  final bool? isEnabled;
  final Color? color;
  final String? text;
  final Map? map;
  final Function? function;
  const MaterialBtn({ 
    Key? key, 
    @required this.color,
    @required this.text,
    @required this.map ,
    @required this.function, 
    @required this.isEnabled, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: this.color,
      disabledColor: Colors.grey,
      child: Text(this.text!, style:BtnStyle.whiteTxtBtn),
      onPressed: !isEnabled! ? null : (){
        function!(
          map
        );
      },
    );
  }
}