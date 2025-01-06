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
      return 'PLease enter a Phone No';
    }
    if (value.length != 10){
      return 'Plase Enter Validate Phone No';
    }
    return null;
  }

  String? validateUsername(value){
    if(value!.isEmpty){
      return 'PLease enter a Phone No';
    }
    return null;
  }

  String? validatePassword(value){
    if(value!.isEmpty){
      return 'PLease enter a Password';
    }
    
    return null;
  }

  
  String? isEmptyCheck(value){
    if(value!.isEmpty){
      return 'PLease fill Details';
    }
    
    return null;
  }

}