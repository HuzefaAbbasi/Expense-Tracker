import 'package:flutter_riverpod/flutter_riverpod.dart';

final incomeOrExpenseProvider = StateProvider<int>((ref) => 0);
final durationProvider = StateProvider<String>((ref) => 'Day');
final addTransactionProvider = StateProvider<int>(
    (ref) => 0); //just used to rebuid widget when transaction is added
