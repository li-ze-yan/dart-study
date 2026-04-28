class BankAccount {
  final String owner;
  double _balance; // _ 开头，库外不可访问

  BankAccount(this.owner, this._balance);

  double get balance => _balance; // 暴露只读

  void deposit(double amount) {
    if (amount <= 0) throw ArgumentError();
    _balance += amount;
  }
}
