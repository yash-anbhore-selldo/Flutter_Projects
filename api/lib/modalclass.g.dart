// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modalclass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      name: json['name'] as String,
      rno: (json['rno'] as num).toInt(),
      marks: (json['marks'] as num).toInt(),
      branch: json['branch'] as String,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'rno': instance.rno,
      'name': instance.name,
      'marks': instance.marks,
      'branch': instance.branch,
    };
