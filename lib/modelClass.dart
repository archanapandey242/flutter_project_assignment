class Model{
  List<Items> items;

  Model({this.items});
  factory Model.fromJson(Map<String, dynamic> json) {
    var itemsList = json['results'] as List;
    List<Items> itemsDetails =
    itemsList.map((i) => Items.fromJson(i)).toList();
    return Model(
      items: itemsDetails,
    );
  }

}

class Items{
  String name,status,species,gender,image;
  Items({this.name,this.status,this.species,this.gender,this.image});
  factory Items.fromJson(Map<String, dynamic> json){
    return Items(
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image']
    );
  }
}