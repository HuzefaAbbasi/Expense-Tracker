import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/models/transaction.dart';
import 'package:money_tracker/utils/toast.dart';

class FirebaseInsert {
  final databaseRef = FirebaseDatabase.instance.ref('Transactions');
  final _auth = FirebaseAuth.instance;

  Future<bool> insertTransaction(MyTransaction transaction) async {
    var isAdded = false;
    final userId = _auth.currentUser!.uid.toString();
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    await databaseRef.child(id).set({
      'id': id,
      'transactionType': transaction.type,
      'title': transaction.title,
      'category': transaction.category,
      'date': transaction.date,
      'amount': transaction.amount,
      'userId': userId
    }).then((value) {
      MyToast.makeToast('Added Successfully');
      isAdded = true;
    }).onError((error, stackTrace) {
      MyToast.makeToast(error.toString());
      isAdded = false;
    });
    return isAdded;
  }
}
