class CartModel {
  String? name;
  int? price;
  int? quantity;
  bool? isChoosed;
  String? image;
  CartModel ({this.image, this.price, this.quantity, this.isChoosed = false, this.name});
}