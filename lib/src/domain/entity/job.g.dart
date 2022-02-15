// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      slug: json['slug'] as String?,
      title: json['title'] as String?,
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
    );
