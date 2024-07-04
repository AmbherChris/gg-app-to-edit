import 'package:flutter/material.dart';
import 'package:gg_app/models/plants.dart';

class PlantScreen extends StatefulWidget {
  final Plant plant;

  const PlantScreen({super.key, required this.plant});

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

// Define an enum for content states
enum ContentState { description, uses, benefits }

class _PlantScreenState extends State<PlantScreen> {
  // Track the current content state
  ContentState _contentState = ContentState.description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top 35% with background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Hero(
              tag: widget.plant.image_path,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.plant.image_path),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom 65% with content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: Color(0xFFF5EFE6), // Cream color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              if (_contentState == ContentState.benefits) {
                                _contentState = ContentState.uses;
                              } else if (_contentState == ContentState.uses) {
                                _contentState = ContentState.description;
                              } else {
                                Navigator.pop(context);
                              }
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.plant.eng_name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              _contentState == ContentState.description
                                  ? 'Description'
                                  : _contentState == ContentState.uses
                                      ? 'Uses'
                                      : 'Benefits',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _contentState == ContentState.description
                                  ? widget.plant.description ?? ''
                                  : _contentState == ContentState.uses
                                      ? widget.plant.uses ?? ''
                                      : widget.plant.benefits ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_contentState ==
                                          ContentState.description) {
                                        _contentState = ContentState.uses;
                                      } else if (_contentState ==
                                          ContentState.uses) {
                                        _contentState = ContentState.benefits;
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    shadowColor: Colors.black.withOpacity(0.3),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    _contentState == ContentState.description
                                        ? 'Uses'
                                        : _contentState == ContentState.uses
                                            ? 'Benefits'
                                            : 'Benefits',
                                    style: TextStyle(
                                      fontFamily: 'Karla',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Implement Process functionality
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    shadowColor: Colors.black.withOpacity(0.3),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    'Process',
                                    style: TextStyle(
                                      fontFamily: 'Karla',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Note: While GreenGem offers information on the potential health benefits of herbal plants, it is not a substitute for professional medical advice. Please consult healthcare professionals before using herbal remedies, especially if you have existing medical conditions or are taking medications.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
