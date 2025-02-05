import 'dart:convert';

import 'package:api/modalclass.dart';
import 'package:http/http.dart' as http;

class ApiforStud{

  static const url = 'https://my.api.mockaroo.com/student.json?key=2f322de0';

  Future<List<Student>> fetchStudent () async {

    final response = await  http.get(Uri.parse(url));

    // it is of type string
    print("RESPONE AFTER the get ${response.body}"); // list of data in string
    print("RESPONE AFTER the get ${response.body.runtimeType}"); // string


    if(response.statusCode == 200){
      // we convert the string into dart obj
      final List<dynamic> data = json.decode(response.body);
      print("Json Decode $data");
      // we convert the list to Map
      return data.map((json)=>Student.fromJson(json)).toList();
    }
    else{
      return [];
    }

  }

}
