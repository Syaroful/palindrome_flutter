import 'package:flutter/material.dart';
import 'package:palindrome_flutter/page/third_screen.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({
    super.key,
    required this.name,
    this.userName = '',
  });

  final String name;
  String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Second Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome'),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                (userName.isEmpty)
                    ? 'Selected User Name'
                    : 'You Select $userName',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: MaterialButton(
                onPressed: () {
                  _navigateToThirdScreen(context);
                },
                color: Colors.cyan,
                minWidth: double.infinity,
                textColor: Colors.white,
                child: Text('Choose User Name'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToThirdScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThirdScreen(),
      ),
    );

    if (result != null) {
      userName = result;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have selected $result'),
        ),
      );
    }
  }
}
