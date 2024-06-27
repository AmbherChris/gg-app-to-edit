import 'package:flutter/material.dart';
import 'package:gg_app/models/plants.dart';
import 'package:gg_app/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'plant_data.dart';

late Box<Plant> box;

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlantAdapter());
  box = await Hive.openBox<Plant>('plantBox');

  // Add initial data
  if (box.isEmpty) {
    allPlants.forEach((plant) {
      box.put(plant.eng_name.toLowerCase().replaceAll(' ', '-'), plant);
    });
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
