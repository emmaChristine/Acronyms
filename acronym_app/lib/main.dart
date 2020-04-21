/**
 *
 * Small app written using Flutter to browse acronyms based on categories.
 */

import 'package:flutter/material.dart';
//import 'dart:convert';

// Parse json file in the background
//Future<List<Photo>> fetchPhotos(http.Client client) async {
//  final response =
//  await client.get('https://jsonplaceholder.typicode.com/photos');
//
//  // Use the compute function to run parsePhotos in a separate isolate.
//  return compute(parsePhotos, response.body);
//}

// A function that converts a response body into a List<Abbreviation>.
//List<Photo> parseAbbreviations(String responseBody) {
//  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//
//  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
//}

void main() => runApp(MyApp());

class Acronym {
  final String title;
  final String description;
  final String category;

  Acronym(this.title, this.description, this.category);
}

class Category {
  final String title;
  final List<Acronym> items;

  Category(this.title, this.items);
}

final _biggerFont = const TextStyle(fontSize: 18.0);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acronyms finder',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Acronyms finder'),
    );
  }

}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _categories = <String> ['Cloud Computing', 'Blogging', 'AI', 'Database',
    'Development', 'IT Security', 'Server/IT Infrastructure', 'Network/Internet'];

  @override
  Widget build(BuildContext context) {

    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        title: Text(widget.title),
      ),
      body: _buildCategories(_categories),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  // #docregion _buildCategories
  Widget _buildCategories(List<String> categories) {
    return ListView.builder(
      itemCount: _categories.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {

          return _buildCategoryRow(_categories[i]);
        });
  }
  // #enddocregion _buildCategories

  // #docregion _buildRow
  Widget _buildCategoryRow(String category) {

    return Card(
        child: ListTile(
            title: Text(
                category,
                style: TextStyle(fontFamily: 'LatoRegular', fontSize: 18.0)),
            trailing: Icon(Icons.chevron_right),
            onTap: (){
              print('xxx');

              Acronym acronym1 = new Acronym("1", "description 1", category);
              Acronym acronym2 = new Acronym("2", "description 2", category);

              Category selectedCategory = new Category(category, [acronym1, acronym2]);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(category: selectedCategory),
                  settings: RouteSettings(
                    arguments: selectedCategory,
                  ),
                ),
              );

        }
        ));
  }
// #enddocregion _buildRow

}


// Category is immutable, ie widget build is called only once
class CategoryScreen extends StatelessWidget {

  final Category category;

  CategoryScreen({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Build the UI for this category
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        //title: Text('Title test'),
      ),
      body: _buildCategoryDetails(category),
    );
  }

  // #docregion _buildCategoryDetails
  Widget _buildCategoryDetails(Category category) {
    return ListView.builder(
        itemCount: category.items.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {

          return _buildAcronymRow(category.items[i]);
        });
  }
  // #enddocregion _buildCategoryDetails


  // #docregion _buildAcronymRow
  Widget _buildAcronymRow(Acronym acronym) {
    return Card(
        child: ListTile(
            title: Text(
                acronym.title,
                style: TextStyle(fontFamily: 'LatoRegular', fontSize: 18.0)),
            subtitle: Text(acronym.description),

            onTap: () {
              print('TODO save to favourites');
            }
        ));
  }
// #enddocregion _buildAcronymRow

}

/// The base class for the different types of items the list can contain.
/// // ListItem describes individual acronym and their meaning.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      "search",
      style: Theme.of(context).textTheme.headline,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}