import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'company.g.dart';

@immutable
@JsonSerializable()
class Company extends Equatable {
  final String? slug;
  final String? name;

  const Company({
    required this.slug,
    required this.name,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  @override
  List<Object?> get props => [slug, name];
}
