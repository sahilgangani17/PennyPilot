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

  String? validateAmount(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an Amount';
    }
    if (value.startsWith('-')) {
      return 'Please enter a valid amount';
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

  String? validateNewPassword(value){
    String passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$';

    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    final regExp = RegExp(passwordPattern);
    if (!regExp.hasMatch(value)) {
      return '''Password must contain the following: 
      • 8-20 characters
      • at least one uppercase letter
      • one lowercase letter
      • one number
      • one special character
      ''';
    }
    
    return null;
  }

  String? isEmptyCheck(value){
    if(value!.isEmpty){
      return 'Please fill Details';
    }
    
    return null;
  }

}