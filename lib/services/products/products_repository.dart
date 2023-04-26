import 'package:sport/extensions/imports.dart';
import 'package:sport/services/products/models/product.dart';

class ProductsRepository {
  static final double _sneakerWidth = 240.w;
  List<Product> products = [
    Product(
      id: 0,
      brand: 'Nike',
      subTitle: 'epic-react',
      price: 130,
      picture: Image.asset(
        'sneaker_01'.png,
        width: _sneakerWidth,
      ),
      footSize: [
        FootSize.mSize,
        FootSize.lSize,
        FootSize.xxlSize,
      ],
      onTap: () {},
      color: const Color(0xFFff9191),
    ),
    Product(
      id: 1,
      brand: 'Nike',
      subTitle: 'air-max',
      price: 160,
      footSize: [
        FootSize.mSize,
        FootSize.lSize,
      ],
      picture: Image.asset(
        'sneaker_02'.png,
        width: _sneakerWidth,
      ),
      onTap: () {},
      color: Colors.amber,
    ),
    Product(
      id: 2,
      brand: 'Nike',
      subTitle: 'epic-react',
      price: 130,
      footSize: [
        FootSize.mSize,
        FootSize.lSize,
      ],
      picture: Image.asset(
        'sneaker_03'.png,
        width: _sneakerWidth,
      ),
      onTap: () {},
      color: Colors.blue,
    ),
    Product(
      footSize: [
        FootSize.mSize,
        FootSize.lSize,
      ],
      id: 3,
      brand: 'Nike',
      subTitle: 'air-max',
      price: 160,
      picture: Image.asset(
        'sneaker_04'.png,
        width: _sneakerWidth,
      ),
      onTap: () {},
      color: Colors.amber,
    ),
  ];

  Future<List<Product>> get $getProducts => Future.value(products);
  Future<Product?> getProductByID(int id) async {
    try {
      return products.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }
}
