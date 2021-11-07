class Item{
  late int _id;
  late String _kind;
  late String _title;
  late double _price;
  late double _weight;
  late String _photo;

  int get id { return _id; }
  String get kind{ return _kind; }
  String get title{ return _title; }
  double get price{ return _price; }
  double get weight{ return _weight; }
  String get photo{ return _photo; }

  String get info{
    return "$_kind $_title $weight g ($_price ₽)";
  }

  Item(int id, String kind, String title, double price, double weight, String photo){
    _id = id;
    _kind = kind;
    _title = title;
    _price = price;
    _weight = weight;
    _photo = photo;
  }
  static fromMap(Map<String, dynamic> map){
    return new Item(
        map['id'],
        map['kind'],
        map['title'],
        map['price'],
        map['weight'],
        map['photo']
    );
  }
}