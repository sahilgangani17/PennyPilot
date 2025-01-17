import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

double convertStringToDouble(String string) {
  double? amount = double.tryParse(string);
  if (amount != null && amount < 0) {
    return 0;
  }
  return amount!;
}

String? getCurrentUserEmail() {
  return FirebaseAuth.instance.currentUser!.email;
}