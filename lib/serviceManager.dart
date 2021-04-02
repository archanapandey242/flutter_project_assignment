import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter_assignment/modelClass.dart';
import 'package:http/http.dart' as http;
class ServiceManager{
  static HttpClient client;

  static Future<dynamic> get(int pageNumber, String name) async {
    String url;
    try {
      url = 'https://rickandmortyapi.com/api/character/?page=$pageNumber&name=$name';
      final response = await  http.get(
          Uri.parse(url),
          headers: {"Accept": "application/json"}
      );
      List<Model> list = List();
      list.add(Model.fromJson(json.decode(response.body.toString())));
      return list;
    } catch (exception) {
      throw "Failed";
    }
  }
}