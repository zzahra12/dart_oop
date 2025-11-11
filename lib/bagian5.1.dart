class Expense {
  String _description;
  double _amount;
  String _category;
  DateTime _date;

  Expense({
    required String description,
    required double amount,
    required String category,
    required DateTime date,
  })  : _description = description,
        _amount = amount,
        _category = category,
        _date = date;

  // Getter
  String get description => _description;
  double get amount => _amount;
  String get category => _category;
  DateTime get date => _date;

  // Mengembalikan nomor minggu ISO (minggu dimulai Senin)
  int getWeekNumber() {
    // Ambil hari ke-berapa dalam minggu sebagai ISO (Senin=1..Minggu=7)
    int weekday = _date.weekday;
    // Geser ke hari Kamis minggu yang sama (trik ISO week)
    DateTime thursday = _date.add(Duration(days: 4 - weekday));
    // Hari pertama tahun dari tahun thursday
    DateTime firstOfYear = DateTime(thursday.year, 1, 1);
    // Hitung jumlah hari antara thursday dan firstOfYear
    int daysDiff = thursday.difference(firstOfYear).inDays;
    // Minggu ke-... (floor div 7) + 1
    return (daysDiff ~/ 7) + 1;
  }

  // Mengembalikan kuartal (1..4)
  int getQuarter() {
    return ((_date.month - 1) ~/ 3) + 1;
  }

  // Apakah tanggal akhir pekan (Sabtu/Minggu)?
  bool isWeekend() {
    return _date.weekday == DateTime.saturday ||
           _date.weekday == DateTime.sunday;
  }

  void printDetails() {
    String d = '${_date.day.toString().padLeft(2,'0')}/${_date.month.toString().padLeft(2,'0')}/${_date.year}';
    print('[$_category] $_description - Rp${_amount.toStringAsFixed(2)} pada $d');
  }
}

void main() {
  var expense = Expense(
    description: 'Brunch akhir pekan',
    amount: 45.00,
    category: 'Makanan',
    date: DateTime(2025, 10, 11), // Sabtu
  );

  expense.printDetails();
  print('Minggu ke-${expense.getWeekNumber()}'); // mis. 41
  print('Kuartal: ${expense.getQuarter()}');      // 4
  print('Akhir pekan? ${expense.isWeekend()}');   // true
}
