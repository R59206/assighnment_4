import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programming Language Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProgrammingLanguageScreen(),
    );
  }
}

class ProgrammingLanguageScreen extends StatefulWidget {
  @override
  _ProgrammingLanguageScreenState createState() => _ProgrammingLanguageScreenState();
}

class _ProgrammingLanguageScreenState extends State<ProgrammingLanguageScreen> {
  // Search controller
  TextEditingController searchController = TextEditingController();

  // Sample data for the expandable list with more programming languages
  List<Map<String, dynamic>> languageData = [
    {
      'parent': 'Python',
      'note': 'Python is a high-level, interpreted programming language.',
      'version': '3.9.7',
      'creator': 'Guido van Rossum',
      'year': 1991,
      'description': 'Python is an interpreted, object-oriented, high-level programming language. Its design philosophy emphasizes code readability with its notable use of significant indentation.',
    },
    {
      'parent': 'Java',
      'note': 'Java is a class-based, object-oriented programming language.',
      'version': '16.0.1',
      'creator': 'James Gosling',
      'year': 1995,
      'description': 'Java is a general-purpose programming language that follows the "write once, run anywhere" philosophy. It is widely used for building scalable applications and web services.',
    },
    {
      'parent': 'C++',
      'note': 'C++ is a general-purpose programming language created as an extension of C.',
      'version': '11.0.1',
      'creator': 'Bjarne Stroustrup',
      'year': 1983,
      'description': 'C++ is a powerful general-purpose programming language that supports both object-oriented and generic programming features. It is widely used for system and application software.',
    },
    {
      'parent': 'JavaScript',
      'note': 'JavaScript is a high-level programming language for web development.',
      'version': 'ES6',
      'creator': 'Brendan Eich',
      'year': 1995,
      'description': 'JavaScript is a programming language used to create interactive effects within web browsers. It enables web pages to dynamically update without reloading.',
    },
    {
      'parent': 'Swift',
      'note': 'Swift is a general-purpose, compiled programming language developed by Apple.',
      'version': '5.5',
      'creator': 'Chris Lattner',
      'year': 2014,
      'description': 'Swift is a powerful and intuitive programming language for iOS, macOS, watchOS, and tvOS applications. It is designed to work with Apple’s Cocoa and Cocoa Touch frameworks.',
    },
    {
      'parent': 'Go',
      'note': 'Go (Golang) is a statically typed, compiled programming language designed by Google.',
      'version': '1.18',
      'creator': 'Robert Griesemer, Rob Pike, Ken Thompson',
      'year': 2009,
      'description': 'Go is a fast, statically typed, compiled language designed for simplicity and efficiency in building software. It is known for its performance, concurrency, and simplicity in writing web servers, networking tools, and more.',
    },
    {
      'parent': 'Ruby',
      'note': 'Ruby is a dynamic, open-source programming language with a focus on simplicity and productivity.',
      'version': '3.1.0',
      'creator': 'Yukihiro Matsumoto',
      'year': 1995,
      'description': 'Ruby is known for its elegant syntax, which is natural to read and easy to write. It is widely used for web development, particularly with the Ruby on Rails framework.',
    },
    {
      'parent': 'Kotlin',
      'note': 'Kotlin is a modern, statically typed programming language that runs on the JVM.',
      'version': '1.5.21',
      'creator': 'JetBrains',
      'year': 2011,
      'description': 'Kotlin is a fully interoperable language with Java. It is designed to be more concise, expressive, and safer than Java, while still being able to run on the Java Virtual Machine (JVM).',
    },
    {
      'parent': 'PHP',
      'note': 'PHP is a popular general-purpose scripting language especially suited to web development.',
      'version': '8.0',
      'creator': 'Rasmus Lerdorf',
      'year': 1994,
      'description': 'PHP is a widely-used, open-source server-side scripting language that is especially suited for web development. It powers some of the most popular websites and content management systems.',
    },
    {
      'parent': 'Rust',
      'note': 'Rust is a systems programming language focused on safety, speed, and concurrency.',
      'version': '1.57',
      'creator': 'Graydon Hoare',
      'year': 2010,
      'description': 'Rust is designed for performance and safety, particularly safe concurrency. It is used for system-level programming and has seen increasing popularity in web and game development.',
    },
  ];

  // The currently opened note, if any
  String? openedNote;

  // Filtered language data based on search
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = languageData;  // initially, show all data
    searchController.addListener(() {
      filterLanguages();
    });
  }

  // Filter languages based on search query
  void filterLanguages() {
    setState(() {
      filteredData = languageData
          .where((lang) =>
          lang['parent']
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programming Language Notes'),
      ),
      body: Column(
        children: [
          // Search bar with icon inside the text field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Programming Languages',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search), // Search icon inside the text field
              ),
            ),
          ),
          // Custom expandable list view
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                var item = filteredData[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        item['parent'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        // Toggle the note visibility
                        if (openedNote == item['parent']) {
                          openedNote = null; // Close the opened note
                        } else {
                          openedNote = item['parent']; // Open this language's note
                        }
                      });
                    },
                    subtitle: openedNote == item['parent']
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['note']),
                        SizedBox(height: 8),
                        Text("Version: ${item['version']}"),
                        Text("Creator: ${item['creator']}"),
                        Text("Year: ${item['year']}"),
                        SizedBox(height: 8),
                        Text(item['description'], maxLines: 3, overflow: TextOverflow.ellipsis),
                      ],
                    )
                        : null,
                    trailing: Icon(
                      openedNote == item['parent'] ? Icons.expand_less : Icons.expand_more,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
