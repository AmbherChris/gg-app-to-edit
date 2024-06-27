import 'package:flutter/material.dart';
import 'package:gg_app/models/plants.dart';
import 'package:gg_app/plant_data.dart';
import 'plant_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Plant> displayedPlants = allPlants; // Default to all plants
  String selectedCategory = 'All plants'; // Default category

  void filterPlants(String category) {
    setState(() {
      selectedCategory = category;
      switch (category) {
        case 'All plants':
          displayedPlants = allPlants;
          break;
        case 'Culinary Herbs':
          displayedPlants = culinaryHerbs;
          break;
        case 'Herbal Teas':
          displayedPlants = herbalTeas;
          break;
        case 'Aromatic Oils':
          displayedPlants = aromaticOils;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.black,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                color: Colors.white,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16.0,
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome to\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        WidgetSpan(
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [Color(0xff205901), Color(0xff7bac31)],
                            ).createShader(bounds),
                            child: Text(
                              'GreenGem',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff205901), Color(0xff7bac31)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.filter_list),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff205901), Color(0xff7bac31)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: IconButton(
                      icon:
                          Icon(Icons.camera_alt, size: 50, color: Colors.white),
                      onPressed: () {
                        // Implement plant scanner feature
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryButton(
                          label: 'All plants',
                          isSelected: selectedCategory == 'All plants',
                          onTap: filterPlants),
                      CategoryButton(
                          label: 'Culinary Herbs',
                          isSelected: selectedCategory == 'Culinary Herbs',
                          onTap: filterPlants),
                      CategoryButton(
                          label: 'Herbal Teas',
                          isSelected: selectedCategory == 'Herbal Teas',
                          onTap: filterPlants),
                      CategoryButton(
                          label: 'Aromatic Oils',
                          isSelected: selectedCategory == 'Aromatic Oils',
                          onTap: filterPlants),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      return GridView.count(
                        crossAxisCount:
                            orientation == Orientation.portrait ? 2 : 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: displayedPlants.map((plant) {
                          return PlantCard(plant: plant);
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(String) onTap;

  CategoryButton(
      {required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        onPressed: () => onTap(label),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected
              ? Colors.green
              : const Color.fromARGB(255, 190, 190, 190),
          shadowColor: Colors.black.withOpacity(0.5),
          elevation: isSelected ? 4 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.transparent),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final Plant plant;

  PlantCard({required this.plant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlantScreen(plant: plant),
          ),
        );
      },
      child: Card(
        color: Color(0xFFF5EFE6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: plant.image_path,
                child: Image.asset(plant.image_path, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.eng_name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
