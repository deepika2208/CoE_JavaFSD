import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HeadlinesPage extends StatefulWidget {
  const HeadlinesPage({super.key});

  @override
  _HeadlinesPageState createState() => _HeadlinesPageState();
}

class _HeadlinesPageState extends State<HeadlinesPage> {
  List _news = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=2bc9aaa1644544dba2f809c1927d6966'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _news = data['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Latest Headlines',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Container(
        color: const Color(0xFFFFE0B2), 
        child: _news.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _news.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: Colors.grey.shade300,
                    color: Colors.white, 
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      title: Text(
                        _news[index]['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        _news[index]['source']['name'],
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      leading: _news[index]['urlToImage'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                _news[index]['urlToImage'],
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
