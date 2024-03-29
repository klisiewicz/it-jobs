import 'package:equatable/equatable.dart';
import 'package:it_jobs/src/domain/entity/company.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'job.g.dart';

@immutable
@JsonSerializable()
class Job extends Equatable {
  final String? slug;
  final String? title;
  final Company? company;

  const Job({
    required this.slug,
    required this.title,
    required this.company,
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  @override
  List<Object?> get props => [slug, title, company];
}
