import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/pages/map.jpeg'), // Ensure the path is correct
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            'lib/pages/image.png',
            errorBuilder: (context, error, stackTrace) {
              return Text('Error loading image: $error');
            },
          ),
        ),
      ),
    );
  }
}
