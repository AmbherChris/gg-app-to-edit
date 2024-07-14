import 'package:flutter/material.dart';
import 'package:gg_app/language_manager.dart';
import 'package:gg_app/models/plants.dart';
import 'package:gg_app/plant_data.dart';
import 'package:provider/provider.dart';
import 'plant_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Plant> displayedPlants = allPlants; // Default to all plants
  String selectedCategory = 'All plants'; // Default category
  TextEditingController searchController = TextEditingController();
  List<Plant> searchResults = [];

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

  void searchPlants(String query) {
    setState(() {
      if (query.isEmpty) {
        searchResults = [];
      } else {
        searchResults = allPlants.where((plant) {
          return plant.eng_name.toLowerCase().contains(query.toLowerCase()) ||
              plant.tag_name.toLowerCase().contains(query.toLowerCase()) ||
              plant.sci_name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void navigateToPlant(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantScreen(
          plant: plant,
          isEnglish:
              Provider.of<LanguageManager>(context, listen: false).isEnglish,
        ),
      ),
    );
  }

  void navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.39,
                color: Colors.black,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.61,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
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
                          controller: searchController,
                          onChanged: searchPlants,
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
                          onPressed: navigateToSettings,
                          icon: SvgPicture.asset(
                            'assets/icons/settings-adjust-svgrepo-com.svg',
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (searchResults.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(searchResults[index].eng_name),
                          onTap: () {
                            navigateToPlant(searchResults[index]);
                          },
                        );
                      },
                    ),
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
                      icon: SvgPicture.asset(
                        'assets/icons/scan-svgrepo-com.svg',
                        width: 100,
                        height: 100,
                      ),
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
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CategoryButton(
                          label: 'All plants',
                          isSelected: selectedCategory == 'All plants',
                          onTap: filterPlants,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CategoryButton(
                          label: 'Culinary Herbs',
                          isSelected: selectedCategory == 'Culinary Herbs',
                          onTap: filterPlants,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CategoryButton(
                          label: 'Herbal Teas',
                          isSelected: selectedCategory == 'Herbal Teas',
                          onTap: filterPlants,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xff7bac31)
              : Color.fromARGB(255, 224, 224, 224),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    final languageManager = Provider.of<LanguageManager>(context);
    bool isEnglish = languageManager.isEnglish;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlantScreen(
              plant: plant,
              isEnglish: isEnglish,
            ),
          ),
        );
      },
      child: Card(
        color: Color(0xFFF5EFE6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.7),
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
                  isEnglish ? plant.eng_name : plant.tag_name,
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
