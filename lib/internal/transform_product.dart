import 'package:lichi_app/domain/models/product.dart';

class TransformProduct {
  static Product transformSingleProduct(dynamic value) {
    var aProduct = value['api_data']['aData'];
    var htmlDescription = aProduct['descriptions']['html'];
    aProduct['description'] = htmlDescription;
    var current = aProduct['colors']['current'];
    aProduct['current'] = current;
    var other = aProduct['colors']['other'];
    aProduct['other'] = other;
    return Product.fromJson(aProduct);
  }

  static List<Product> transformListProduct(dynamic value) {
    var aProducts = value['api_data']['aProduct'];
    List<Product> valueProducts = (aProducts as List<dynamic>).map((aProduct) {
      var htmlDescription = aProduct['descriptions']['html'];
      aProduct['description'] = htmlDescription;
      var current = aProduct['colors']['current'];
      aProduct['current'] = current;
      var other = aProduct['colors']['other'];
      aProduct['other'] = other;
      return Product.fromJson(aProduct);
    }).toList();
    return valueProducts;
  }
}
