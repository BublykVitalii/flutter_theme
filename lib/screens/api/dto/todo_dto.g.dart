// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoDTO _$TodoDTOFromJson(Map<String, dynamic> json) => TodoDTO(
      json['title'] as String,
      json['id'] as String,
      json['note'] as String,
      json['complete'] as bool,
      (json['todos'] as List<dynamic>)
          .map((e) => TodoDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoDTOToJson(TodoDTO instance) => <String, dynamic>{
      'complete': instance.complete,
      'id': instance.id,
      'note': instance.note,
      'title': instance.title,
      'todos': instance.todos,
    };
