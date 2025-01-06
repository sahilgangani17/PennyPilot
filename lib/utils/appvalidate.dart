class Appvalidate {
  
  String? validateEmail(value){
    if (value!.isEmpty){
      return 'Please Enter an Email';
    }
  
    RegExp emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)){
      return 'Please enter a valid Email';
    }
    return null;
  }

  String? validatePhoneNo(value){
    if(value!.isEmpty){
      return 'Please enter a Phone No';
    }
    if (value.length != 10){
      return 'Please enter a valid Phone No';
    }
    return null;
  }

  String? validateUsername(value){
    if(value!.isEmpty){
      return 'Please enter an Username';
    }
    return null;
  }

  String? validatePassword(value){
    if(value!.isEmpty){
      return 'Please enter a Password';
    }
    
    return null;
  }

}