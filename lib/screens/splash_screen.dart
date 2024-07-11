import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTermsAccepted();
  }

  Future<void> _checkTermsAccepted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool accepted = prefs.getBool('termsAccepted') ?? false;

    if (!accepted) {
      _showTermsDialog();
    }
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TermsDialog(onAccept: _navigateToHomePage);
      },
    );
  }

  void _closeApp() {
    Navigator.of(context).pop();
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              // Background image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Logo image
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.0005),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: screenWidth * 0.60,
                    height: screenHeight * 0.60,
                  ),
                ),
              ),
              // Center text
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Text(
                    'Your Gateway to Herbal Wellness',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.04,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Karla',
                    ),
                  ),
                ),
              ),
              // Get Started button
              Column(
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.10),
                      child: OutlinedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool accepted =
                              prefs.getBool('termsAccepted') ?? false;

                          if (accepted) {
                            _navigateToHomePage();
                          } else {
                            _showTermsDialog();
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          side:
                              const BorderSide(color: Colors.white, width: 2.0),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.15,
                            vertical: screenHeight * 0.012,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: screenHeight * 0.03,
                            fontFamily: 'Karla',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class TermsDialog extends StatefulWidget {
  final VoidCallback onAccept;

  const TermsDialog({required this.onAccept});

  @override
  _TermsDialogState createState() => _TermsDialogState();
}

class _TermsDialogState extends State<TermsDialog> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Terms and Conditions'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Scroll down to accept\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                    text: '1. Introduction\n',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text:
                        'Welcome to GreenGem, your ultimate herbal companion app. These terms and conditions govern your use of the GreenGem mobile application. By accessing or using the app, you agree to comply with these terms.\n\n',
                  ),
                  TextSpan(
                    text: '2. Content and Information\n',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text:
                        'The content provided in the GreenGem app, including, articles, tutorials, images, and videos, is for informational purposes only.\n\nWe strive to ensure the accuracy and reliability of the information provided in the app. However, we do not guarantee the completeness or correctness of any content.\n\nPlant information and recommendations are based on research and expert knowledge. Users should exercise their judgment and consider local conditions when applying any advice provided in the app.\n\nThe GreenGem app does not constitute medical advice, and we disclaim any liability for any loss or damage arising from the use of the information provided in the app. Users are encouraged to exercise caution and seek professional medical guidance when making decisions about their health and wellness.\n\n',
                  ),
                  TextSpan(
                    text: '3. Usage Restrictions\n',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text:
                        'You agree not to misuse the GreenGem app or use it for any unlawful purpose.\n\nYou may not modify, adapt, sublicense, translate, sell, or exploit any part of the app without our prior written consent.\n\n',
                  ),
                  TextSpan(
                    text: '4. Privacy Policy\n',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text:
                        'The GreenGem App does not collect, store, or use any personal information from its users. As our App does not require user accounts, we do not collect names, addresses, phone numbers, email addresses, or any other personally identifiable information.\n\n',
                  ),
                  TextSpan(
                    text: '5. Termination\n',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text:
                        'We reserve the right to suspend or terminate your access to the GreenGem app at any time, without prior notice or liability, for any reason.\n\n',
                  ),
                  TextSpan(
                    text: '6. Changes to Terms\n',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text:
                        'We may update or revise these terms and conditions from time to time. The revised version will be effective upon posting on the app. Your continued use of the GreenGem app after any changes constitutes acceptance of those changes.\n\n',
                  ),
                  TextSpan(
                    text: '7. Contact Us\n',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text:
                        'If you have any questions or concerns about these terms and conditions, please contact us at greengem@gmail.com',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'I have read and agree to the terms and conditions.',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Decline'),
          onPressed: () {
            Navigator.of(context).pop();
            _closeApp();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey,
            textStyle: const TextStyle(fontFamily: 'Karla'),
          ),
        ),
        ElevatedButton(
          child: const Text('Accept'),
          onPressed: _isChecked
              ? () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('termsAccepted', true);
                  Navigator.of(context).pop();
                  widget.onAccept();
                }
              : null,
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontFamily: 'Karla'),
            disabledForegroundColor: Colors.green.withOpacity(0.38),
            disabledBackgroundColor: Colors.green.withOpacity(0.12),
            foregroundColor: Colors.white,
            backgroundColor: _isChecked ? Colors.green : null,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  void _closeApp() {
    Navigator.of(context).pop();
  }
}
