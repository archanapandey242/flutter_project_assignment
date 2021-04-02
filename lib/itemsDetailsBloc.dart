import 'dart:async';
import 'package:flutter_assignment/modelClass.dart';
import 'package:flutter_assignment/serviceManager.dart';


abstract class Bloc {
  void dispose();
}
class ItemsDetailsBloc implements Bloc {
  final _controller =
  StreamController<List<Model>>.broadcast();
  Stream<List<Model>> get stream =>
      _controller.stream;
  List<Model> itemList = List();
  List<Model> itemListDetails = [];

  void fnGetItemsList(int pageNumber, String name) async {
    itemList.clear();
    itemList =  await ServiceManager.get(pageNumber,name);
    if (itemList != null) {
      itemListDetails.addAll(itemList);
      _controller.sink.add(itemListDetails);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}


