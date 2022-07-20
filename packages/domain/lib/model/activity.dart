import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'activity.g.dart';

@JsonSerializable()
@CopyWith()
class Activity {
  final String name;
  final String? note;

  const Activity({required this.name, this.note});

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
