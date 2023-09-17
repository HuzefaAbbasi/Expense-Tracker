// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyTransaction1 {
  final int id;
  final String image;
  final String title;
  final String day;
  final double amount;
  //true for income, false for expense.
  final bool type;

  MyTransaction1(
    this.id,
    this.image,
    this.title,
    this.day,
    this.amount,
    this.type,
  );
}

class MyTransaction {
  final int id;
  final int type;
  final String title;
  final int category;
  final String date;
  final double amount;

  MyTransaction(
      this.id, this.type, this.title, this.category, this.date, this.amount);
}

class TransactionModel {
  List<MyTransaction1> list = [
    MyTransaction1(
        1, 'assets/icons/income_icon.png', 'Income', 'Yesterday', 200, true)
  ];
}
