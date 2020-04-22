/**
 *
 * Small app written using Flutter to browse acronyms based on categories.
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
//  return parsed.map<Category>((json) => Category.fromJson(json)).toList();
//}

// Parse json file in the background
Future<List<Category>> fetchAllFromAssets(String assetPath) async {
  return dummyData();
}


List<Category> dummyData() {
  List<Category> categories = new List();
  Acronym acronym1 = new Acronym("AWS", "Amazon Web Services", 'Cloud Computing');
  Acronym acronym2 = new Acronym("S3", "Simple Storage System", 'Cloud Computing');

  categories.add(new Category('CloudComputing', [acronym1, acronym2]));

  Acronym acronym3 = new Acronym("AI", "Artificial Intelligence", 'AI');
  Acronym acronym4 = new Acronym("IMS", "Intelligent Maintenance Systems", 'AI');

  categories.add(new Category('AI', [acronym3, acronym4]));

  return categories;
}
List<Category>  parseAllFromLocalJson() {

  // if no local data source return null;

  List<Category> categories = new List();
  Acronym acronym1 = new Acronym("1", "description 1", 'Cloud Computing');
  Acronym acronym2 = new Acronym("2", "description 2", 'Cloud Computing');

  categories.add(new Category('CloudComputing', [acronym1, acronym2]));

  Acronym acronym3 = new Acronym("3", "description 3", 'AI');
  Acronym acronym4 = new Acronym("4", "description 4", 'AI');

  categories.add(new Category('AI', [acronym3, acronym4]));


  for (int i=0; i<20; i++)
    categories.add(new Category('AI', [acronym3, acronym4]));

  return categories;
}

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

//  factory Category.fromJson(Map<String, dynamic> json) {
//    return Category(
//      title: json['title'] as String,
//      items: json['items'] as List<Acronym>,
//    );
//  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AcronymsTheme',
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
//        primarySwatch: Colors.green,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        brightness: Brightness.light,

        // Default font family
        fontFamily: 'LatoRegular',

        // Default text styling for headlines, titles, bodies of text etc.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),

        )
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
  Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchAllFromAssets('acronyms.json');
  }

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
      body: FutureBuilder<List<Category>>(
        future: futureCategories,
        builder:(context, snapshot) {
          if (snapshot.hasData) {
            return _buildCategories(snapshot.data);
          }

          return new Center(child: new CircularProgressIndicator());
        }
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add acronym',
        child: Icon(Icons.add),

        onPressed: () {
          print('Action not supported yet.');
//          Scaffold.of(context).showSnackBar(new SnackBar(
//            content: Text('Action not supported yet.'),
//          ));
        }
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  // #docregion _buildCategories
  Widget _buildCategories(List<Category> categories) {
    return ListView.builder(
      itemCount: categories.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {

          return _buildCategoryRow(categories[i]);
        });
  }
  // #enddocregion _buildCategories

  // #docregion _buildRow
  Widget _buildCategoryRow(Category category) {

    return Card(
        child: ListTile(
            title: Text(
                category.title),
            trailing: Icon(Icons.chevron_right),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(category: category),
                  settings: RouteSettings(
                    arguments: category,
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
                acronym.title),
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