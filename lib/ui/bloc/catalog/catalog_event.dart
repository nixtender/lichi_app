abstract class CatalogEvent {}

class CatalogLoadingEvent extends CatalogEvent {
  String cloth;

  CatalogLoadingEvent({required this.cloth});
}

class CatalogScrollEvent extends CatalogEvent {}
