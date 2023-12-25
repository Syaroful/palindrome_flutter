import 'package:flutter/material.dart';
import 'package:palindrome_flutter/page/second_screen.dart';

class FisrtScreen extends StatefulWidget {
  const FisrtScreen({super.key});

  @override
  State<FisrtScreen> createState() => _FisrtScreenState();
}

class _FisrtScreenState extends State<FisrtScreen> {
  String name = '';
  String sentence = '';
  bool isPalindrome = false;

  void checkPalindrome() {
    String cleanedText =
        sentence.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    String reversedText = cleanedText.split('').reversed.join('');
    isPalindrome = cleanedText == reversedText;
  }

  @override
  void dispose() {
    // Clean up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onChanged: (text) {
                setState(() {
                  name = text;
                });
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Polindrome',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onChanged: (text) {
                setState(() {
                  sentence = text;
                });
              },
            ),
            SizedBox(
              height: 36,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  checkPalindrome();
                  if (sentence.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              isPalindrome ? 'Palindrome' : 'Not Palindrome'),
                          content: Text(isPalindrome
                              ? 'The word "$sentence" is palindrome'
                              : 'The word "$sentence" is not palindrome'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              },
              color: Colors.cyan,
              minWidth: double.infinity,
              textColor: Colors.white,
              child: Text('CHECK'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondScreen(name: name)));
              },
              color: Colors.cyan,
              minWidth: double.infinity,
              textColor: Colors.white,
              child: Text('NEXT'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
