import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'company.g.dart';

@JsonSerializable()
class Company extends Equatable {
  final String slug;
  final String name;

  Company({
    @required this.slug,
    @required this.name,
  }) : super([slug, name]);

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  @visibleForTesting
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
