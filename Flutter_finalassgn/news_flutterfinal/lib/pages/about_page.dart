import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor:Color.fromARGB(255, 155, 50, 2),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        color: Colors.grey[200], 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            Icon(
              Icons.newspaper,
              size: 60,
              color: Color.fromARGB(255, 155, 50, 2),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to Live News App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 155, 50, 2),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Your go-to source for real-time updates and breaking headlines worldwide. '
                      'We bring you the latest news across various categories, including politics, business, technology, sports, entertainment, and more—right at your fingertips.\n\n'
                      '🌎 Key Features:\n'
                      '✔ Live news updates from reliable sources\n'
                      '✔ Easy-to-navigate categories\n'
                      '✔ Personalized news experience\n'
                      '✔ Quick access to trending stories\n\n'
                      'Stay updated, stay informed—because news should be available at your convenience!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(221, 15, 15, 15),
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}