// ===== CLASS DASAR: Expense =====
class Expense {
  String description;
  double amount;
  String category;
  DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  void printDetails() {
    String d =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    print('[$category] $description - Rp${amount.toStringAsFixed(2)} ($d)');
  }
}

// ===== CLASS MENENGAH: RecurringExpense =====
class RecurringExpense extends Expense {
  String frequency; // harian, mingguan, bulanan, tahunan

  RecurringExpense({
    required String description,
    required double amount,
    required String category,
    required this.frequency,
    DateTime? date,
  }) : super(
          description: description,
          amount: amount,
          category: category,
          date: date,
        );

  // Total per tahun berdasarkan frekuensi
  double yearlyTotal() {
    switch (frequency.toLowerCase()) {
      case 'harian':
        return amount * 365;
      case 'mingguan':
        return amount * 52;
      case 'bulanan':
        return amount * 12;
      default:
        return amount;
    }
  }

  @override
  void printDetails() {
    super.printDetails();
    print('Frekuensi: $frequency');
  }
}

// ===== CLASS AKHIR: SubscriptionExpense =====
class SubscriptionExpense extends RecurringExpense {
  String provider;
  String plan;
  DateTime startDate;
  DateTime? endDate;

  SubscriptionExpense({
    required String description,
    required double amount,
    required this.provider,
    required this.plan,
    required this.startDate,
    this.endDate,
  }) : super(
          description: description,
          amount: amount,
          category: 'Langganan',
          frequency: 'bulanan',
        );

  bool isActive() {
    DateTime now = DateTime.now();
    if (endDate == null) return true; // Tidak ada end date = aktif
    return now.isBefore(endDate!);
  }

  int getRemainingMonths() {
    if (endDate == null) return -1; // Tak terbatas
    DateTime now = DateTime.now();
    if (now.isAfter(endDate!)) return 0;

    int months = (endDate!.year - now.year) * 12 + (endDate!.month - now.month);
    return months;
  }

  double getTotalCost() {
    if (endDate == null) {
      // Tidak ada end date → hitung untuk 1 tahun
      return yearlyTotal();
    }

    int months =
        (endDate!.year - startDate.year) * 12 + (endDate!.month - startDate.month);
    return amount * months;
  }

  @override
  void printDetails() {
    print('📱 LANGGANAN');
    print('$description ($provider - $plan)');
    print('Biaya: Rp${amount.toStringAsFixed(2)}/bulan');
    print('Mulai: ${startDate.toString().split(' ')[0]}');

    if (endDate != null) {
      print('Berakhir: ${endDate.toString().split(' ')[0]}');
      print('Sisa: ${getRemainingMonths()} bulan');
    } else {
      print('Berakhir: Tidak pernah (berkelanjutan)');
    }

    print('Status: ${isActive() ? "Aktif ✅" : "Expired ❌"}');
    print('Total biaya: Rp${getTotalCost().toStringAsFixed(2)}');
  }
}

// ===== MAIN FUNCTION =====
void main() {
  var netflix = SubscriptionExpense(
    description: 'Netflix Premium',
    amount: 186000,
    provider: 'Netflix',
    plan: 'Premium 4K',
    startDate: DateTime(2024, 1, 1),
    endDate: null, // Berkelanjutan
  );

  var trial = SubscriptionExpense(
    description: 'Adobe Creative Cloud',
    amount: 800000,
    provider: 'Adobe',
    plan: 'Semua Apps',
    startDate: DateTime(2025, 9, 1),
    endDate: DateTime(2025, 12, 31),
  );

  netflix.printDetails();
  print('\n');
  trial.printDetails();
}