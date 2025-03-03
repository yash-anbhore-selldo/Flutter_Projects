import 'package:json_annotation/json_annotation.dart';
part 'modalclass.g.dart';

//flutter pub run build_runner build  run this until then it show error for the _$StudnetFromJson(json)
@JsonSerializable()
class Student {
  int rno;
  String name;
  int marks;
  String branch;

  Student(
      {required this.name,
      required this.rno,
      required this.marks,
      required this.branch});

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  // Map<String,dynamic> because json is (key , value) {"name" : "Yash", "rno" : 2}
  // factory Student.fromJson(Map<String, dynamic> json) =>
  // _$StudentFromJson(json);
}

// factory Student.fromJson(Map<String, dynamic> json) {
// return Student(
// name: json['name'],
// rno: json['rno'],
// marks: json['marks'],
// branch: json['branch']);
// }
