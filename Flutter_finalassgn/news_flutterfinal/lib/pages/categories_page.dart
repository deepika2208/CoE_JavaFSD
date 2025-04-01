import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});

  final List<String> categories = [
    'Business', 'Entertainment', 'Health', 'Science', 'Sports', 'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Categories')),
      body: Container(
        color: const Color(0xFFFFE0B2), 
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              elevation: 3,
              color: Colors.white,
              child: ListTile(
                title: Text(categories[index]),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryNewsPage(category: categories[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryNewsPage extends StatefulWidget {
  final String category;

  const CategoryNewsPage({super.key, required this.category});

  @override
  _CategoryNewsPageState createState() => _CategoryNewsPageState();
}

class _CategoryNewsPageState extends State<CategoryNewsPage> {
  List<dynamic> articles = [];
  bool isLoading = true;
  bool hasError = false;
  Set<String> favoriteArticles = {};

  @override
  void initState() {
    super.initState();
    fetchCategoryNews();
    loadFavorites();
  }

  Future<void> fetchCategoryNews() async {
    final String apiKey = '2bc9aaa1644544dba2f809c1927d6966';
    final String category = widget.category.toLowerCase();
    final String url =
        'https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          articles = data['articles'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  Future<void> loadFavorites() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('favorites').get();
    setState(() {
      favoriteArticles = snapshot.docs.map((doc) => doc['title'].toString()).toSet();
    });
  }

  void toggleFavorite(Map<String, dynamic> article) async {
    String title = article['title'] ?? 'No Title';

    CollectionReference favorites = FirebaseFirestore.instance.collection('favorites');
    QuerySnapshot existingArticle = await favorites.where('title', isEqualTo: title).get();

    if (existingArticle.docs.isNotEmpty) {
      for (var doc in existingArticle.docs) {
        await doc.reference.delete();
      }
      setState(() {
        favoriteArticles.remove(title);
      });
    } else {
      await favorites.add({
        'title': title,
        'description': article['description'] ?? 'No Description',
        'urlToImage': article['urlToImage'] ?? '',
      });
      setState(() {
        favoriteArticles.add(title);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.category} News')),
      body: Container(
        color: const Color(0xFFFFE0B2),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : hasError
                ? const Center(child: Text('Failed to load news. Try again later.'))
                : ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      String title = article['title'] ?? 'No Title';

                      return Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 4,
                        color: Colors.white, 
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: article['urlToImage'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    article['urlToImage'],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.image, size: 80, color: Colors.grey),
                          title: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            article['description'] ?? 'No Description',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              favoriteArticles.contains(title) ? Icons.favorite : Icons.favorite_border,
                              color: favoriteArticles.contains(title) ? Colors.red : null,
                            ),
                            onPressed: () => toggleFavorite(article),
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Opening article...')),
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
