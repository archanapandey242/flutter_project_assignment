import 'package:flutter/material.dart';
import 'package:flutter_assignment/itemsDetails.dart';
import 'package:flutter_assignment/itemsDetailsBloc.dart';
import 'package:flutter_assignment/modelClass.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ItemsDetailsBloc itemsDetailsBloc;
  Icon _searchIcon = new Icon(Icons.search);//search icon in app bar
  Widget _appBarTitle = new Text('Search');//text in app bar
  final searchController = TextEditingController();//textController for search
  ScrollController _controller;//controller for pagination
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    itemsDetailsBloc = ItemsDetailsBloc();//initializing bloc
    itemsDetailsBloc.fnGetItemsList(1, "");//calling api
    _controller = ScrollController()..addListener(_scrollListener);//initializing controller for pagination
  }

  //----------------------------scrollListener for pagination--------------------
  void _scrollListener() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        itemsDetailsBloc.fnGetItemsList(pageNumber++, "");
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _appBarTitle,
          actions: [
            IconButton(
              onPressed: () {
                _searchPressed();
              },
              icon: _searchIcon,
            )
          ],
        ),
        body: StreamBuilder<List<Model>>(
            stream: itemsDetailsBloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  controller: _controller,
                    itemCount: fnItemsLength(snapshot).length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          fnItemsLength(snapshot)[index].image),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(fnItemsLength(snapshot)[index].name.length>30?
                                fnItemsLength(snapshot)[index].name.replaceRange(30, fnItemsLength(snapshot)[index].name.length,"...")
                                  :fnItemsLength(snapshot)[index].name,
                                  overflow: TextOverflow.ellipsis,),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemsDetails(
                                      fnItemsLength(snapshot)[index])),
                            );
                          },
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

//-----------------Search functionality---------------------
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextFormField(
          cursorColor: Colors.black,
          controller: searchController,
          decoration: new InputDecoration(
            prefixIcon: new Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: 'Search by name',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onChanged: (text) {
            itemsDetailsBloc.fnGetItemsList(1, searchController.text.toString());
          },
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search');
      }
    });
  }

//----------------function return total result list items---------------------
  List<Items> fnItemsLength(AsyncSnapshot<List<Model>> snapshot) {
    List<Items> list = [];
    list.clear();
    for(int i=0;i<snapshot.data.length;i++){
      list.addAll(snapshot.data[i].items);
    }
    return list;
  }
}
