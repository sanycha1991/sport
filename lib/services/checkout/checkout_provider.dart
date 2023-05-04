import 'package:sport/extensions/imports.dart';
import 'package:sport/services/products/models/product.dart';

class CheckoutProvider extends ChangeNotifier {
  String simpleStateUpdate = UniqueKey().toString();

  List<Product> checkoutProducts = [];
  List<Product> lastRemoved = [];
  List<Product> lastAdded = [];

  int get totalItems =>
      checkoutProducts.where((e) => e.cart!.quantity > 0).length;

  bool isLastAdded(Product item) => lastAdded.contains(item);
  bool isLastRemoved(Product item) => lastRemoved.contains(item);

  resetLasts() {
    lastAdded = [];
    lastRemoved = [];
    updateState();
  }

  double get totalPrice {
    return checkoutProducts.fold(
      0.0,
      (total, product) => total + product.price * product.cart!.quantity,
    );
  }

  void addProduct(Product product) {
    if (!checkoutProducts.contains(product)) {
      product.cart = Cart(quantity: 1);

      checkoutProducts.add(product);
    } else {
      checkoutProducts
          .firstWhere((e) => e.id == product.id, orElse: null)
          .cart!
          .quantity++;
    }

    lastAdded.add(product);

    updateState();
  }

  void addLastRemoved(Product product) {
    lastRemoved.add(product);
    updateState();
  }

  void decreaseQuantityProduct(Product product) async {
    try {
      Cart? cart = checkoutProducts
          .firstWhere((e) => e.id == product.id, orElse: null)
          .cart as Cart;

      if (cart.quantity == 1) {
        addLastRemoved(product);
        checkoutProducts.removeWhere((e) => e.id == product.id);
      } else {
        cart.quantity--;
      }

      updateState();
    } catch (e) {}
  }

  void updateState() {
    simpleStateUpdate = UniqueKey().toString();
    notifyListeners();
  }
}
