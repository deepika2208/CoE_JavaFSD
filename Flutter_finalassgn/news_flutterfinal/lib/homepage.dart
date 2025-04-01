import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization.dart';
import 'pages/headlines_page.dart';
import 'pages/categories_page.dart';
import 'pages/about_page.dart';
import 'pages/notes_page.dart';
import 'pages/favorites_page.dart';
import 'pages/important_days.dart'; 

class HomePage extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  const HomePage({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('app_title'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF9800),
              Color(0xFFFF7043),
              Color(0xFFFFAB91),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context).translate('homepage_text'),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                shadows: [
                  Shadow(blurRadius: 5, color: Colors.black26, offset: Offset(1, 1))
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                padding: const EdgeInsets.all(10),
                children: <Widget>[
                  _buildCard(context, Icons.article, 'latest_headlines', HeadlinesPage()),
                  _buildCard(context, Icons.category, 'news_categories', CategoriesPage()),
                  _buildCard(context, Icons.favorite, 'favorites', FavoritesPage()),
                  _buildCard(context, Icons.info, 'about', AboutPage()),
                  _buildCard(context, Icons.note, 'news_notes', NotesPage()),
                  _buildCard(context, Icons.event, 'important_days', ImportantDaysPage()), 
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildLanguageChips(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String key, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => page,
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.deepOrange),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context).translate(key),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageChips() {
    final List<Map<String, String>> languages = [
      {'label': 'English', 'code': 'en'},
      {'label': 'Español', 'code': 'es'},
      {'label': 'Français', 'code': 'fr'},
      {'label': 'தமிழ்', 'code': 'ta'},
      {'label': 'తెలుగు', 'code': 'te'},
      {'label': 'हिन्दी', 'code': 'hi'},
      {'label': 'ಕನ್ನಡ', 'code': 'kn'},
      {'label': 'മലയാളം', 'code': 'ml'},
      {'label': 'বাংলা', 'code': 'bn'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: languages.map((lang) {
        return ActionChip(
          label: Text(lang['label']!),
          backgroundColor: Colors.deepOrangeAccent.withOpacity(0.8),
          labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          onPressed: () {
            onLocaleChange(Locale(lang['code']!));
          },
        );
      }).toList(),
    );
  }
}
