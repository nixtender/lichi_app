import 'package:lichi_app/data/services/database.dart';
import 'package:lichi_app/domain/models/product_base.dart';

class DataService {
  Future cuProduct(ProductBase productBase) async {
    if (productBase.count == 0) {
      await DB.instance.delete<ProductBase>(productBase);
    }
    await DB.instance.createUpdate(productBase);
  }
}
