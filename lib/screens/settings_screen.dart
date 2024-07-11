import 'package:flutter/material.dart';

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
                      _buildSettingsButton(context, 'Language'),
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

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          content: SingleChildScrollView(
            child: Text(
              content,
              style: TextStyle(fontFamily: 'Montserrat'),
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
                backgroundColor: Colors.green,
              ),
            ),
          ],
        );
      },
    );
  }

  String _termsContent() {
    return '''
1. Introduction
Welcome to GreenGem, your ultimate herbal companion app. These terms and conditions govern your use of the GreenGem mobile application. By accessing or using the app, you agree to comply with these terms.

2. Content and Information
The content provided in the GreenGem app, including, articles, tutorials, images, and videos, is for informational purposes only. We strive to ensure the accuracy and reliability of the information provided in the app. However, we do not guarantee the completeness or correctness of any content.

Plant information and recommendations are based on research and expert knowledge. Users should exercise their judgment and consider local conditions when applying any advice provided in the app. The GreenGem app does not constitute medical advice, and we disclaim any liability for any loss or damage arising from the use of the information provided in the app. Users are encouraged to exercise caution and seek professional medical guidance when making decisions about their health and wellness.

3. Usage Restrictions
You agree not to misuse the GreenGem app or use it for any unlawful purpose. You may not modify, adapt, sublicense, translate, sell, or exploit any part of the app without our prior written consent.

4. Privacy Policy
The GreenGem App does not collect, store, or use any personal information from its users. As our App does not require user accounts, we do not collect names, addresses, phone numbers, email addresses, or any other personally identifiable information.

5. Termination
We reserve the right to suspend or terminate your access to the GreenGem app at any time, without prior notice or liability, for any reason.

6. Changes to Terms
We may update or revise these terms and conditions from time to time. The revised version will be effective upon posting on the app. Your continued use of the GreenGem app after any changes constitutes acceptance of those changes.

7. Contact Us
If you have any questions or concerns about these terms and conditions, please contact us at greengem@gmail.com
    ''';
  }
}
