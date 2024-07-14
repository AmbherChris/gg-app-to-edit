import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gg_app/language_manager.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                color: Colors.black,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.87,
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
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16.0,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildSettingsButton(context, 'Language', () {
                        _showLanguageDialog(context);
                      }),
                      _buildSettingsButton(
                        context,
                        'Terms & Conditions',
                        () => _showDialog(
                          context,
                          'Terms and Conditions',
                          _termsContent(),
                        ),
                      ),
                      _buildSettingsButton(
                        context,
                        'Disclaimer',
                        () => _showDialog(
                          context,
                          'Disclaimer',
                          'While GreenGem offers information on the potential health benefits of herbal plants, it is not a substitute for professional medical advice. Please consult healthcare professionals before using herbal remedies, especially if you have existing medical conditions or are taking medications.',
                        ),
                      ),
                      _buildSettingsButton(
                        context,
                        'About',
                        () => _showDialog(
                          context,
                          'About',
                          'GreenGem is the ultimate destination for herbal plant enthusiasts, offering valuable insights into the diverse world of botanical wonders. Our platform provides detailed information on various herbs, empowering users to explore their properties and applications with confidence. Join us on a journey to holistic wellness and reconnect with nature\'s healing power. Contact us for inquiries or feedback.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context, String label,
      [VoidCallback? onTap]) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff205901), Color(0xff7bac31)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    bool selectedLanguage = context.read<LanguageManager>().isEnglish;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Select Language',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title:
                    Text('English', style: TextStyle(fontFamily: 'Montserrat')),
                leading: Radio<bool>(
                  value: true,
                  groupValue: selectedLanguage,
                  onChanged: (bool? value) {
                    selectedLanguage = value!;
                    (context as Element).markNeedsBuild();
                  },
                ),
              ),
              ListTile(
                title:
                    Text('Tagalog', style: TextStyle(fontFamily: 'Montserrat')),
                leading: Radio<bool>(
                  value: false,
                  groupValue: selectedLanguage,
                  onChanged: (bool? value) {
                    selectedLanguage = value!;
                    (context as Element).markNeedsBuild();
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(fontFamily: 'Karla'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
              ),
            ),
            TextButton(
              child: Text(
                'Apply',
                style: TextStyle(fontFamily: 'Karla'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _confirmLanguageChange(context, selectedLanguage);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmLanguageChange(BuildContext context, bool isEnglish) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Confirm Language Change',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
          content: Text(
            'Are you sure you want to change the language?',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontFamily: 'Karla'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
              ),
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(fontFamily: 'Karla'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<LanguageManager>().switchLanguage();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              content,
              style: TextStyle(fontFamily: 'Montserrat'),
              textAlign: TextAlign.justify,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(fontFamily: 'Karla'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  String _termsContent() {
    return '''
        Welcome to GreenGem! By accessing and using our app, you agree to the following terms and conditions:

        1. Content Accuracy: GreenGem provides information on herbal plants for educational purposes. While we strive for accuracy, we cannot guarantee the completeness or reliability of the information.

        2. Medical Advice: The information on GreenGem is not a substitute for professional medical advice. Always consult healthcare professionals before using herbal remedies.

        3. User Responsibility: Users are responsible for their actions and decisions based on the information provided. GreenGem is not liable for any consequences arising from the use of our content.

        4. Privacy: We value your privacy and handle your personal data in accordance with our Privacy Policy.

        5. Changes: GreenGem may update these terms and conditions at any time. Continued use of the app implies acceptance of the revised terms.
        ''';
  }
}
