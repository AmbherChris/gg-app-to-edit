import 'package:hive/hive.dart';

part 'plants.g.dart';

@HiveType(typeId: 1)
class Plant {
  Plant({
    required this.eng_name,
    required this.tag_name,
    required this.sci_name,
    required this.description,
    required this.image_path,
    required this.uses,
    required this.benefits,
    required this.process,
    required this.tag_description,
    required this.tag_uses,
    required this.tag_benefits,
    required this.tag_process,
    required this.video_url,
  });

  @HiveField(0)
  String eng_name;

  @HiveField(1)
  String tag_name;

  @HiveField(2)
  String sci_name;

  @HiveField(3)
  String description;

  @HiveField(4)
  String image_path;

  @HiveField(5)
  String uses;

  @HiveField(6)
  String benefits;

  @HiveField(7)
  String process;

  @HiveField(8)
  String tag_description;

  @HiveField(9)
  String tag_uses;

  @HiveField(10)
  String tag_benefits;

  @HiveField(11)
  String tag_process;

  @HiveField(12)
  String video_url;
}
