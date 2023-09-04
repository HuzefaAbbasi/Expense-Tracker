import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/models/transaction.dart';
import 'package:money_tracker/utils/toast.dart';

class FirebaseInsert {
  final databaseRef = FirebaseDatabase.instance.ref('Transactions');

  Future<bool> insertTransaction(MyTransaction transaction) async {
    var isAdded = false;
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    await databaseRef.child(id).set({
      'id': id,
      'transactionType': transaction.type,
      'title': transaction.title,
      'category': transaction.category,
      'date': transaction.date,
      'amount': transaction.amount
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
