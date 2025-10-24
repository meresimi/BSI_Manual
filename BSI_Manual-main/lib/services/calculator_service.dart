\
import 'package:flutter/foundation.dart';
import 'rate_service.dart';

class CartItem {
  final RateItem rate;
  int quantity;
  CartItem({required this.rate, this.quantity = 1});
  double get total => rate.amount * quantity;
}

class CalculatorService extends ChangeNotifier {
  final RateService rates;
  final List<CartItem> _cart = [];
  String _note = '';

  CalculatorService(this.rates);

  List<CartItem> get cart => List.unmodifiable(_cart);
  String get note => _note;

  void add(RateItem rate) {
    final idx = _cart.indexWhere((c) => c.rate.code == rate.code);
    if (idx == -1) {
      _cart.add(CartItem(rate: rate));
    } else {
      _cart[idx].quantity += 1;
    }
    notifyListeners();
  }

  void remove(String code) {
    _cart.removeWhere((c) => c.rate.code == code);
    notifyListeners();
  }

  void setQuantity(String code, int qty) {
    final idx = _cart.indexWhere((c) => c.rate.code == code);
    if (idx != -1) {
      _cart[idx].quantity = qty < 1 ? 1 : qty;
      notifyListeners();
    }
  }

  double get total => _cart.fold(0.0, (p, c) => p + c.total);

  void setNote(String v) {
    _note = v;
    notifyListeners();
  }

  void clear() {
    _cart.clear();
    _note = '';
    notifyListeners();
  }
}
