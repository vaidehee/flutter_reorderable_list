import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class ReorderableListScreen extends StatefulWidget {
  @override
  _ReorderableListScreenState createState() => _ReorderableListScreenState();
}

enum _ReorderableListType {
  threeLine,
}

class _ListItem {
  _ListItem(this.value, this.checkState);

  final String value;

  bool checkState;
}

class _ReorderableListScreenState extends State<ReorderableListScreen> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  PersistentBottomSheetController<void> _bottomSheet;
  _ReorderableListType _itemType = _ReorderableListType.threeLine;
  bool _reverse = false;
  bool _reverseSort = false;

  final List<_ListItem> _items = <String>[
    'All of My Stars',
    'Faded',
    'Mercy',
    'Girl Like You',
    'Ed Photograph',
    'Cheap Thrills',
    'Shape of You',
    'Closer',
    'See you again',
    'Love me like you do',
    'All of Me',
    'Thinking out loud',
    'Lean On',
    'Love Your Self',
  ].map<_ListItem>((String item) => _ListItem(item, false)).toList();

  void changeItemType(_ReorderableListType type) {
    setState(() {
      _itemType = type;
    });
    _bottomSheet?.setState(() {

    });
    _bottomSheet?.close();
  }

  void changeReverse(bool newValue) {
    setState(() {
      _reverse = newValue;
    });
    _bottomSheet?.setState(() {});
    _bottomSheet?.close();
  }

  Widget buildListTile(_ListItem item) {
    Widget listTile;
    switch (_itemType) {
      case _ReorderableListType.threeLine:
        listTile = Container(
          padding: EdgeInsets.all(10.0),
          key: Key(item.value),
          decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0)),
          margin:
              EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
          child: ListTile(
            key: Key(item.value),
            title: Text(
              'Listen to ${item.value}.',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            leading: Icon(Icons.reorder),
            trailing: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
        );
    }

    return listTile;
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final _ListItem item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Listen From the Latest Albums'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            tooltip: 'Sort by Alphabets',
            onPressed: () {
              setState(() {
                _reverseSort = !_reverseSort;
                _items.sort((_ListItem a, _ListItem b) => _reverseSort
                    ? b.value.compareTo(a.value)
                    : a.value.compareTo(b.value));
              });
            },
          ),
        ],
      ),
      body: Scrollbar(
        child: ReorderableListView(
          header: _itemType != _ReorderableListType.threeLine
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Header of the list',
                      style: Theme.of(context).textTheme.headline))
              : null,
          onReorder: _onReorder,
          reverse: _reverse,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: _items.map<Widget>(buildListTile).toList(),
        ),
      ),
    );
  }
}
