class Product {
  int? id;
  String name;
  int quantity;
  double price;

  Product({this.id,required this.name,required this.quantity,required this.price});

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name: data['name'],
      quantity: data['quantity'],
      price: data['price']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
      'quantity' : quantity,
      'price' : price
    };
  }
  @override
  String toString() {
    return ' Id: $id\n Name: $name\n Quantity: $quantity\n Price: $price';
  }
}