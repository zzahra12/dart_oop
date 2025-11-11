// ===== Class Dasar: Expense =====
class Expense {
  String _description;
  double _amount;
  String _category;
  DateTime _date;

  Expense({
    required String description,
    required double amount,
    required String category,
    DateTime? date,
  })  : _description = description,
        _amount = amount,
        _category = category,
        _date = date ?? DateTime.now();

  // Getter
  String get description => _description;
  double get amount => _amount;
  String get category => _category;
  DateTime get date => _date;

  // Method sederhana untuk menampilkan info
  void printDetails() {
    String d =
        '${_date.day.toString().padLeft(2, '0')}/${_date.month.toString().padLeft(2, '0')}/${_date.year}';
    print('[$_category] $_description - Rp${_amount.toStringAsFixed(2)} ($d)');
  }
}

// ===== Class Turunan: BusinessExpense =====
class BusinessExpense extends Expense {
  String client;
  bool isReimbursable;

  BusinessExpense({
    required String description,
    required double amount,
    required String category,
    required this.client,
    this.isReimbursable = true,
  }) : super(
          description: description,
          amount: amount,
          category: category,
          date: DateTime.now(),
        );

  @override
  void printDetails() {
    print('💼 PENGELUARAN BISNIS');
    super.printDetails();
    print('   Klien: $client');
    print('   Bisa di-reimburse: ${isReimbursable ? "Ya ✅" : "Tidak ❌"}');
  }
}

// ===== Main Function =====
void main() {
  var expense = BusinessExpense(
    description: 'Makan siang klien',
    amount: 85.0,
    category: 'Makan',
    client: 'PT Acme',
    isReimbursable: true,
  );

  expense.printDetails();
}
