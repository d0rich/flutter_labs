class Item{
  late String _kind;
  late String _title;
  late double _price;
  late double _weight;
  late String _photo;

  String get kind{ return _kind; }
  String get title{ return _title; }
  double get price{ return _price; }
  double get weight{ return _weight; }
  String get photo{ return _photo; }

  String get info{
    return "$_kind $_title $weight g ($_price ₽)";
  }

  Item(String kind, String title, double price, double weight, String photo){
    _kind = kind;
    _title = title;
    _price = price;
    _weight = weight;
    _photo = photo;
  }
  static fromMap(Map<String, dynamic> map){
    return new Item(
        map['kind'],
        map['title'],
        map['price'],
        map['weight'],
        map['photo']
    );
  }
}