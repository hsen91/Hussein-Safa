class Validation {
  static String? validEmail(String? email){
    String pattern = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]";
    RegExp regExp = new RegExp(pattern);
    if(email == null || email.isEmpty){
      return 'Please enter an email.';
    }
    else if(!regExp.hasMatch(email)){
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validName(String? name){
    if(name == null || name.isEmpty){
      return 'Please enter a name.';
    }
    else if(name.length<3){
      return 'Please enter a name that consists of three or more letters.';
    }
    return null;
  }

  static String? validPhoneNumber(String? number){
    String pattern = r'(^(?:[+0]9)?[0-9]{8}$)';
    RegExp regExp = new RegExp(pattern);
    if(number == null || number.isEmpty){
      return 'Please enter a phone number.';
    }
    else if(!regExp.hasMatch(number)){
      return 'Please enter a number that consists of 8 digits.';
    }
    return null;
  }

  static String? validMessage(String? message){
    if(message == null || message.isEmpty){
      return 'Please enter your message.';
    }
    return null;
  }
}