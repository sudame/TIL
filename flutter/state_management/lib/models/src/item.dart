const _itemNames = [
  'Code Smell',
  'Control Flow',
  'Interpreter',
  'Recursion',
  'Sprint',
  'Heisenbug',
  'Spaghetti',
  'Hydra Code',
  'Off-By-One',
  'Scope',
  'Callback',
  'Closure',
  'Automata',
  'Bit Shift',
  'Currying',
];

class Item {
  final int id;
  final String name;

  Item(this.id) : this.name = _itemNames[id % _itemNames.length];

  @override
  int get hashCode => this.id;

  @override
  bool operator ==(other) => other is Item && other.id == this.id;
  


}