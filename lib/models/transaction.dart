// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyTransaction {
  final int id;
  final String image;
  final String title;
  final String day;
  final double amount;
  //true for income, false for expense.
  final bool type;

  MyTransaction(
    this.id,
    this.image,
    this.title,
    this.day,
    this.amount,
    this.type,
  );
}

class TransactionModel {
  List<MyTransaction> list = [
    MyTransaction(
        1, 'assets/icons/income_icon.png', 'Income', 'Yesterday', 200, true)
  ];
}
