import 'package:lichi_app/const/my_string.dart';

abstract class CatalogEvent {}

class CatalogLoadingEvent extends CatalogEvent {
  String cloth;

  CatalogLoadingEvent({required this.cloth});
}
