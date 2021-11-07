import 'package:tpu_mobile_labs/support/lab6/item.dart';

class ItemModel{
  final int? id;
  final String kind;
  final String title;
  final double price;
  final double weight;
  final String photo;

  ItemModel({
      this.id,
      required this.kind,
      required this.title,
      required this.price,
      required this.weight,
      required this.photo
  });

  static fromItem(Item item){
    return new ItemModel(
        kind: item.kind,
        title: item.title,
        price: item.price,
        weight: item.weight,
        photo: item.photo
    );
  }

  static fromMap(Map<String, dynamic> map){
    return new ItemModel(
        id: map['id'],
        kind: map['kind'],
        title: map['title'],
        price: map['price'],
        weight: map['weight'],
        photo: map['photo']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'kind': kind,
      'title': title,
      'price': price,
      'weight': weight,
      'photo': photo
    };
  }

  @override
  String toString() {
    return 'Item{id: $id, kind: $kind, title: $title, price: $price, weight: $weight, photo: $photo}';
  }
}