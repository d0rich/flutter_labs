class Item{
  late String _kind;
  late String _title;
  late double _price;
  late double _weight;

  String get kind{ return _kind; }
  String get title{ return _title; }
  double get price{ return _price; }
  double get weight{ return _weight; }

  String get info{
    return "$_kind $_title $weight g ($_price ₽)";
  }

  Item(String kind, String title, double price, double weight){
    _kind = kind;
    _title = title;
    _price = price;
    _weight = weight;
  }
}