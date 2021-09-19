import 'package:flutter/material.dart';
import 'package:test_app/main.dart';
import 'package:test_app/validator/validation.dart';


enum FieldType {
  Email,
  Name,
  Phone,
  Message
}
class FormFieldWidget extends StatelessWidget {
  final String? text;
  final FieldType? fieldType;
  final TextInputType? textInputType;
  final bool? hidden;
  final TextEditingController? controller;

  const FormFieldWidget({ 
    Key? key, 
    this.text, 
    this.fieldType, 
    this.textInputType, 
    this.hidden, 
    this.controller, 
  }) : super(key: key);

  FormFieldWidget.name({
    @required this.text, 
    this.fieldType = FieldType.Name, 
    this.textInputType = TextInputType.text, 
    this.hidden = false, 
    @required this.controller, 
  });

  FormFieldWidget.email({
    @required this.text,
    this.fieldType = FieldType.Email, 
    this.textInputType = TextInputType.emailAddress, 
    this.hidden = false, 
    @required this.controller, 
  });

  FormFieldWidget.phone({
    @required this.text,
    this.fieldType = FieldType.Phone, 
    this.textInputType = TextInputType.phone, 
    this.hidden = false, 
    @required this.controller,
  });

  FormFieldWidget.message({
    @required this.text,
    this.fieldType = FieldType.Message, 
    this.textInputType = TextInputType.multiline, 
    this.hidden = false, 
    @required this.controller,
  });



  String? actionText(FieldType type, value) {
    switch (type) {
      case FieldType.Name: return Validation.validName(value);
      case FieldType.Email: return Validation.validEmail(value);
      case FieldType.Phone: return Validation.validPhoneNumber(value);
      case FieldType.Message: return Validation.validMessage(value);
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: this.fieldType == FieldType.Message ? TextCapitalization.sentences : TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: this.textInputType,
      obscureText: this.hidden!,
      minLines: this.fieldType == FieldType.Message ? null:1,
      maxLines: this.fieldType == FieldType.Message ? 5:1,
      validator: (value) => actionText(this.fieldType!, value),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: this.text,
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => this.controller!.text = value!,
    );
  }
}