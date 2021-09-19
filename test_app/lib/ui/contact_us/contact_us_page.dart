import 'package:flutter/material.dart';
import 'package:test_app/Models/contact.dart';
import 'package:test_app/styles/button_style.dart';
import 'package:test_app/ui/contact_us/contact_us_bloc.dart';
import 'package:test_app/widgets/material_button.dart';
import 'package:test_app/widgets/text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({ Key? key }) : super(key: key);
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  

  final ContactUsBloc bloc = ContactUsBloc();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:10.0),
              SizedBox(
                height: 50.0,
                child: Text(AppLocalizations.of(context).note_text),
              ),

              SizedBox(height:10.0),

              StreamBuilder<bool>(
                stream: bloc.jsonButtons,
                builder: (context, snapshot) {
                  bool? isEnabled = snapshot.hasData ? snapshot.data:false;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialBtn(
                        isEnabled: isEnabled,
                        color: Theme.of(context).colorScheme.secondary, 
                        text: AppLocalizations.of(context).create_success,
                        map: {
                          'code': 1,
                          'message': 'Message sent successfully'
                        }, 
                        function: (map) async {
                          bool created = await bloc.createJson(map, 'success');
                          ScaffoldMessenger.of(context).showSnackBar(bloc.showSnackBar(
                            created ? 'Success message created successfully':'Failed to create success message'
                          ));
                        }
                      ),
              
                      MaterialBtn(
                        isEnabled: isEnabled,
                        color: Colors.redAccent, 
                        text: AppLocalizations.of(context).create_fail, 
                        map: {
                          'code': 0,
                          'message': 'Failed to send message'
                        }, 
                        function: (map) async {
                          bool created = await bloc.createJson(map, 'fail');
                          ScaffoldMessenger.of(context).showSnackBar(bloc.showSnackBar(
                            created ? 'Fail message created successfully':'Failed to create fail message'
                          ));
                        }
                      ),
                    ]
                  );
                }
              ),

              SizedBox(height:20.0),

              FormFieldWidget.name(
                text: AppLocalizations.of(context).name,
                controller: nameController,
              ),
        
              SizedBox(height:20.0),
        
              FormFieldWidget.email(
                text: AppLocalizations.of(context).email,
                controller: emailController,
              ),
        
              SizedBox(height:20.0),
              
              FormFieldWidget.phone(
                text: AppLocalizations.of(context).phone,
                controller: phoneController,
              ),
        
              SizedBox(height:20.0),
              
              FormFieldWidget.message(
                text: AppLocalizations.of(context).message,
                controller: msgController,
              ),
        
              SizedBox(height:20.0),
              
              StreamBuilder<bool>(
                stream: bloc.enabled,
                builder: (context, snapshot) {
                  bool? isEnabled = snapshot.hasData ? snapshot.data : false;
                  return MaterialButton(
                    child: Text(AppLocalizations.of(context).send, style: BtnStyle.whiteTxtBtn,),
                    color: Theme.of(context).colorScheme.secondary,
                    //Theme.of(context).accentColor,
                    disabledColor: Colors.grey,
                    onPressed: !isEnabled! ? null : (){
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if(bloc.validator(formKey)){
                        bloc.enabled.add(false);
                        Contact contact = Contact(
                          nameController.text, 
                          emailController.text, 
                          phoneController.text, 
                          msgController.text
                        );
                        Map data =  contact.toJson();
                        bloc.sendMessage(formKey,data);
                      }
                    },
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}