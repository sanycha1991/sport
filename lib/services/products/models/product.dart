import 'package:sport/extensions/imports.dart';

class Product {
  final int id;
  final String brand;
  final String subTitle;
  final double price;
  final Image picture;
  final Function onTap;
  final Color color;
  final List<FootSize> footSize;
  Cart? cart;
  AnimationCardType animationType;
  WhereIsScollGoing whereIsScollGoing;

  Product({
    required this.id,
    required this.brand,
    required this.subTitle,
    required this.price,
    required this.picture,
    required this.onTap,
    required this.color,
    required this.footSize,
    this.cart,
    this.animationType = AnimationCardType.none,
    this.whereIsScollGoing = WhereIsScollGoing.nowhere,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Cart {
  int quantity;
  Cart({
    required this.quantity,
  });
}

class FootSize {
  final int id;
  final String value;
  FootSize({
    required this.id,
    required this.value,
  });

  static FootSize get mSize => FootSize(id: 1, value: '7.5');
  static FootSize get lSize => FootSize(id: 2, value: '8');
  static FootSize get xlSize => FootSize(id: 3, value: '9.5');
  static FootSize get xxlSize => FootSize(id: 4, value: '10');
}

enum AnimationCardType {
  none,
  previousCard,
  nextCard,
}

enum WhereIsScollGoing {
  nowhere,
  left,
  right,
}
