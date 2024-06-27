import 'package:hive/hive.dart';

part 'plants.g.dart';

@HiveType(typeId: 1)
class Plant {
  Plant(
      {required this.eng_name,
      required this.tag_name,
      required this.sci_name,
      required this.description,
      required this.image_path});
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
}
