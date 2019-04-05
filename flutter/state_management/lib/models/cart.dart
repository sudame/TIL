import 'dart:collection';

import 'package:state_management/models/src/item.dart';
import 'package:scoped_model/scoped_model.dart';


class CartModel extends Model {
  // 内部のプライベートなステート
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.length  * 42;

  void add(Item item) {
    _items.add(item);

    notifyListeners();
  }

  void clear(){
    _items.clear();
  }
}
