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

  // ===== Latihan 1 (berbasis waktu) =====
  int getWeekNumber() {
    int weekday = _date.weekday;
    DateTime thursday = _date.add(Duration(days: 4 - weekday));
    DateTime firstOfYear = DateTime(thursday.year, 1, 1);
    int daysDiff = thursday.difference(firstOfYear).inDays;
    return (daysDiff ~/ 7) + 1;
  }

  int getQuarter() => ((_date.month - 1) ~/ 3) + 1;

  bool isWeekend() =>
      _date.weekday == DateTime.saturday || _date.weekday == DateTime.sunday;

  // ===== Latihan 2 (statistik) =====
  double getAmountRounded() {
    return _amount.roundToDouble();
  }

  double getDailyAverage(int days) {
    if (days <= 0) return 0;
    return _amount / days;
  }

  double projectedYearly() {
    return _amount * 12;
  }

  // Helper tambahan untuk tampilan
  String getFormattedAmount() {
    return 'Rp${_amount.toStringAsFixed(2)}';
  }

  void printDetails() {
    String d =
        '${_date.day.toString().padLeft(2, '0')}/${_date.month.toString().padLeft(2, '0')}/${_date.year}';
    print('[$_category] $_description - Rp${_amount.toStringAsFixed(2)} ($d)');
  }
}

void main() {
  var subscription = Expense(
    description: 'Netflix',
    amount: 15.99,
    category: 'Hiburan',
  );

  subscription.printDetails();
  print('Jumlah: ${subscription.getFormattedAmount()}');
  print('Dibulatkan: Rp${subscription.getAmountRounded().toStringAsFixed(2)}');
  print(
      'Rata-rata harian (30 hari): Rp${subscription.getDailyAverage(30).toStringAsFixed(2)}');
  print('Proyeksi tahunan: Rp${subscription.projectedYearly().toStringAsFixed(2)}');
}
