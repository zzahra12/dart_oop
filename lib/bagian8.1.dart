// ===== CLASS DASAR: Expense =====
class Expense {
  String description;
  double amount;
  String category;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
  });

  void payWith(PaymentMethod method) {
    print('💰 Membayar "$description" sebesar Rp${amount.toStringAsFixed(2)} menggunakan ${method.name}');
    method.processPayment(amount);
  }
}

// ===== CLASS ABSTRAK: PaymentMethod =====
abstract class PaymentMethod {
  String get name;
  String get icon;

  bool validate();
  void processPayment(double amount);

  void showReceipt(double amount) {
    print('✅ Pembayaran sebesar Rp${amount.toStringAsFixed(2)} berhasil!');
  }
}

// ===== CLASS TURUNAN: Cryptocurrency =====
class Cryptocurrency extends PaymentMethod {
  final String walletAddress;
  final String coinType;

  Cryptocurrency({
    required this.walletAddress,
    required this.coinType,
  });

  @override
  String get name => 'Dompet $coinType';

  @override
  String get icon => '₿';

  @override
  bool validate() {
    // Validasi sederhana
    return walletAddress.isNotEmpty && walletAddress.length > 20;
  }

  @override
  void processPayment(double amount) {
    if (!validate()) {
      print('❌ Alamat wallet tidak valid');
      return;
    }

    print('$icon Memproses pembayaran $coinType...');
    print('Wallet: ${walletAddress.substring(0, 6)}...${walletAddress.substring(walletAddress.length - 4)}');
    print('⏳ Menunggu konfirmasi blockchain...');
    showReceipt(amount);
  }
}

// ===== MAIN FUNCTION =====
void main() {
  var btc = Cryptocurrency(
    walletAddress: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
    coinType: 'Bitcoin',
  );

  var expense = Expense(
    description: 'Pembelian online',
    amount: 250.0,
    category: 'Belanja',
  );

  expense.payWith(btc);
}
