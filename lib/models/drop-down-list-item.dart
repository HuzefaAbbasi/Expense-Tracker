class MyDropDownListItem {
  final int id;
  final String iconPath;
  final String title;

  MyDropDownListItem(this.iconPath, this.title, this.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyDropDownListItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          iconPath == other.iconPath && // Compare IDs for equality
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}

class MyLists {
  final List<MyDropDownListItem> incomeExpenseList = [
    MyDropDownListItem('assets/icons/income_icon.png', 'Income', 0),
    MyDropDownListItem('assets/icons/expense_icon.png', 'Expense', 1),
  ];

  final List<MyDropDownListItem> incomeCategoriesList = [
    MyDropDownListItem(
        'assets/icons/income_categories/salary.png', 'Salary', 0),
    MyDropDownListItem(
        'assets/icons/income_categories/business.png', 'Business', 1),
    MyDropDownListItem(
        'assets/icons/income_categories/freelance.png', 'Freelance', 2),
    MyDropDownListItem(
        'assets/icons/income_categories/investment.png', 'Investment', 3),
    MyDropDownListItem(
        'assets/icons/income_categories/rental.png', 'Rental', 4),
    MyDropDownListItem('assets/icons/income_categories/others.png', 'Other', 5),
  ];

  final List<MyDropDownListItem> expenseCategoriesList = [
    MyDropDownListItem(
        'assets/icons/expense_categories/housing.png', 'Housing', 0),
    MyDropDownListItem(
        'assets/icons/expense_categories/utilities.png', 'Utilities', 1),
    MyDropDownListItem('assets/icons/expense_categories/food.png', 'Food', 2),
    MyDropDownListItem(
        'assets/icons/expense_categories/education.png', 'Education', 3),
    MyDropDownListItem(
        'assets/icons/expense_categories/travel.png', 'Travel', 4),
    MyDropDownListItem(
        'assets/icons/expense_categories/healthcare.png', 'Health Care', 5),
    MyDropDownListItem('assets/icons/expense_categories/entertainment.png',
        'Entertainment', 6),
    MyDropDownListItem(
        'assets/icons/expense_categories/investment.png', 'Investment', 7),
    MyDropDownListItem(
        'assets/icons/expense_categories/debt.png', 'Debt Payments', 8),
    MyDropDownListItem(
        'assets/icons/expense_categories/others.png', 'Other', 9),
  ];
}
