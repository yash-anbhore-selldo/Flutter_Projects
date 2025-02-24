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

  // Map<String,dynamic> because json is (key , value) {"name" : "Yash", "rno" : 2}
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        name: json['name'],
        rno: json['rno'],
        marks: json['marks'],
        branch: json['branch']);
  }
}
