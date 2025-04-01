import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite News')),
      body: Container(
        color: const Color(0xFFFFE0B2), 
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No favorite news saved.',
                  style: TextStyle(color: Colors.black), 
                ),
              );
            }

            var favoriteArticles = snapshot.data!.docs;

            return ListView.builder(
              itemCount: favoriteArticles.length,
              itemBuilder: (context, index) {
                var article = favoriteArticles[index].data() as Map<String, dynamic>;

                return Card(
                  color: Colors.white.withOpacity(0.8), 
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: article['urlToImage'] != null
                        ? Image.network(article['urlToImage'], width: 80, fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 80),
                    title: Text(article['title'] ?? 'No Title', maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text(article['description'] ?? 'No Description', maxLines: 3, overflow: TextOverflow.ellipsis),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        FirebaseFirestore.instance.collection('favorites').doc(favoriteArticles[index].id).delete();
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
