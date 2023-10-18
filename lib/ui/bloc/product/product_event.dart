abstract class ProductEvent {}

class ProductLoadingEvent extends ProductEvent {
  int? id;

  ProductLoadingEvent([this.id]);
}
