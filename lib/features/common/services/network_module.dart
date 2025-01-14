enum NetworkModule {
  auth('/auth'),
  categories('/categories'),
  currencies('/currencies'),
  quantityUnits('/quantity-units'),
  receipts('/receipts'),
  root('');

  const NetworkModule(this.path);

  final String path;
}
