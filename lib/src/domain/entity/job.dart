import 'package:equatable/equatable.dart';
import 'package:it_jobs/src/domain/entity/company.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'job.g.dart';

@JsonSerializable()
class Job extends Equatable {
  final String slug;
  final String title;
  final Company company;

  Job({
    @required this.slug,
    @required this.title,
    @required this.company,
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  @visibleForTesting
  Map<String, dynamic> toJson() => _$JobToJson(this);

  @override
  List<Object> get props => [slug, title, company];
}
