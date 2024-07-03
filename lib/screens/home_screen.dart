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
                height: MediaQuery.of(context).size.height * 0.39,
                color: Colors.black,
              ),
              Container(
                height: MediaQuery.of(context).size.height *
                    0.12, // 70% of the screen height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
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
                                    MediaQuery.of(context).size.width * 0.10,
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
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
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
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Container(
                        height: 57,
                        width: 57,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff205901), Color(0xff7bac31)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                        ),
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
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
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
                  decoration: BoxDecoration(),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Wrap each CategoryButton with a Container without shadow
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4), // Adjust margin as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8), // Border radius for rounded corners
                        ),
                        child: CategoryButton(
                          label: 'All plants',
                          isSelected: selectedCategory == 'All plants',
                          onTap: filterPlants,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4), // Adjust margin as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8), // Border radius for rounded corners
                        ),
                        child: CategoryButton(
                          label: 'Culinary Herbs',
                          isSelected: selectedCategory == 'Culinary Herbs',
                          onTap: filterPlants,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4), // Adjust margin as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8), // Border radius for rounded corners
                        ),
                        child: CategoryButton(
                          label: 'Herbal Teas',
                          isSelected: selectedCategory == 'Herbal Teas',
                          onTap: filterPlants,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4), // Adjust margin as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8), // Border radius for rounded corners
                        ),
                        child: CategoryButton(
                          label: 'Aromatic Oils',
                          isSelected: selectedCategory == 'Aromatic Oils',
                          onTap: filterPlants,
                        ),
                      ),
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
              ? const Color.fromARGB(255, 81, 173, 85)
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
            color: Color.fromARGB(255, 255, 255, 238),
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
        elevation: 4, // Add shadow
        shadowColor: Colors.black.withOpacity(0.7), // Add shadow color
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: plant.image_path,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(plant.image_path, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  plant.eng_name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
