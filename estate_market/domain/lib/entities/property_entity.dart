abstract class PropertyEntity {
  final double surface;
  final double price;
  final bool isNegotiable;
  final int? constructionYear;
  // location

  PropertyEntity(
      {required this.surface, required this.price, required this.isNegotiable, required this.constructionYear});
}
