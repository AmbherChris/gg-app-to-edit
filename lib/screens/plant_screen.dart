import 'package:flutter/material.dart';
import 'package:gg_app/models/plants.dart';

class PlantScreen extends StatefulWidget {
  final Plant plant;

  const PlantScreen({super.key, required this.plant});

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

enum ContentState {
  description,
  usesAndBenefits,
  process,
}

class _PlantScreenState extends State<PlantScreen> {
  ContentState _contentState = ContentState.description;
  ContentState _previousState = ContentState.description;
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _nextState() {
    setState(() {
      if (_contentState == ContentState.description) {
        _previousState = _contentState;
        _contentState = ContentState.usesAndBenefits;
      } else if (_contentState == ContentState.usesAndBenefits) {
        _previousState = _contentState;
        _contentState = ContentState.process;
      }
      _scrollToTop();
    });
  }

  void _processState() {
    setState(() {
      _previousState = _contentState;
      _contentState = ContentState.process;
      _scrollToTop();
    });
  }

  void _previousStateFunction() {
    setState(() {
      if (_contentState == ContentState.process) {
        _contentState = _previousState;
      } else if (_contentState == ContentState.usesAndBenefits) {
        _contentState = ContentState.description;
      } else {
        Navigator.pop(context);
      }
      _scrollToTop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: Color(0xFFF5EFE6),
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
                          onPressed: _previousStateFunction,
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.plant.eng_name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              _contentState == ContentState.description
                                  ? 'Description'
                                  : _contentState ==
                                          ContentState.usesAndBenefits
                                      ? 'Uses & Benefits'
                                      : 'Process',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            if (_contentState == ContentState.description)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    'Tagalog name: ${widget.plant.tag_name}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Scientific name: ${widget.plant.sci_name}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    widget.plant.description ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            if (_contentState == ContentState.usesAndBenefits)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    widget.plant.uses ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    'Benefits',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    widget.plant.benefits ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            if (_contentState == ContentState.process)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    widget.plant.process ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                            if (_contentState != ContentState.process)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (_contentState == ContentState.description)
                                    ElevatedButton(
                                      onPressed: _nextState,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 32, vertical: 16),
                                        shadowColor:
                                            Colors.black.withOpacity(0.3),
                                        elevation: 5,
                                      ),
                                      child: Text(
                                        'Uses & Benefits',
                                        style: TextStyle(
                                          fontFamily: 'Karla',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ElevatedButton(
                                    onPressed: _processState,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 16),
                                      shadowColor:
                                          Colors.black.withOpacity(0.3),
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
