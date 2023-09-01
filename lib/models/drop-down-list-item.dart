class MyDropDownListItem {
  final String iconPath;
  final String title;

  MyDropDownListItem(this.iconPath, this.title);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyDropDownListItem &&
          runtimeType == other.runtimeType &&
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}

class MyLists {
  final List<MyDropDownListItem> incomeExpenseList = [
    MyDropDownListItem('assets/icons/income_icon.png', 'Income'),
    MyDropDownListItem('assets/icons/expense_icon.png', 'Expense'),
  ];

  final List<MyDropDownListItem> incomeCategoriesList = [
    MyDropDownListItem('assets/icons/income_categories/salary.png', 'Salary'),
    MyDropDownListItem(
        'assets/icons/income_categories/business.png', 'Business'),
    MyDropDownListItem(
        'assets/icons/income_categories/freelance.png', 'Freelance'),
    MyDropDownListItem(
        'assets/icons/income_categories/investment.png', 'Investment'),
    MyDropDownListItem('assets/icons/income_categories/rental.png', 'Rental'),
    MyDropDownListItem('assets/icons/income_categories/others.png', 'Other'),
  ];

  final List<MyDropDownListItem> expenseCategoriesList = [
    MyDropDownListItem(
        'assets/icons/expense_categories/housing.png', 'Housing'),
    MyDropDownListItem(
        'assets/icons/expense_categories/utilities.png', 'Utilities'),
    MyDropDownListItem('assets/icons/expense_categories/food.png', 'Food'),
    MyDropDownListItem(
        'assets/icons/expense_categories/education.png', 'Education'),
    MyDropDownListItem('assets/icons/expense_categories/travel.png', 'Travel'),
    MyDropDownListItem(
        'assets/icons/expense_categories/healthcare.png', 'Health Care'),
    MyDropDownListItem(
        'assets/icons/expense_categories/entertainment.png', 'Entertainment'),
    MyDropDownListItem(
        'assets/icons/expense_categories/investment.png', 'Investment'),
    MyDropDownListItem(
        'assets/icons/expense_categories/debt.png', 'Debt Payments'),
    MyDropDownListItem('assets/icons/expense_categories/others.png', 'Other'),
  ];
}
