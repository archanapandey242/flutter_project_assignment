import 'package:flutter/material.dart';
import 'package:flutter_assignment/modelClass.dart';

class ItemsDetails extends StatefulWidget{
  Items item;
  ItemsDetails(this.item);

  @override
  _ItemsDetailsPageState createState() => _ItemsDetailsPageState();
}
class _ItemsDetailsPageState extends State<ItemsDetails>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(this.widget.item.name),
      ),
      backgroundColor: Colors.grey[10],
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(this.widget.item.image),
                        fit: BoxFit.fill
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Text(this.widget.item.name,style: TextStyle(fontSize: 25),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:50,left: 2,right: 2,),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          textWidget("Species",this.widget.item.species),
                          Divider(thickness: 1,),
                          textWidget("Gender",this.widget.item.gender),
                          Divider(thickness: 1,),
                          textWidget("Status",this.widget.item.status),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//---------------Text widget to show details---------------
  textWidget(String strHeading, String strValue,) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
          children: [
            Text(strHeading),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(":"),
            ),
            Text(strValue)
          ],
        ),
    );
  }

}