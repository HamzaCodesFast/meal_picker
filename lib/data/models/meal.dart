import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'meal.g.dart';

@HiveType(typeId: 0)
class Meal {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double frequency;

  Meal({required this.name})
      : this.id = Uuid().v1(),
        this.frequency = 0;
}
