/**
 *
 * Small app written using Flutter to browse and search acronyms based on categories.
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

  Icon _searchIcon = new Icon(Icons.search);
  final Icon _closeIcon = new Icon(Icons.close);

  // controls the text label we use as a search bar
  final TextEditingController _filter = new TextEditingController();

  // names filtered by search
  List filteredAcronyms = new List<Acronym>();

  // names we get from local data set
  List allAcronyms = new List<Acronym>();

  String _searchText = "";

  Widget _appBarTitle = new Text( 'Search Example' );

  _MyHomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredAcronyms = allAcronyms;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  // load data once, as it is immutable
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
        title: _appBarTitle,
        centerTitle: true,
        leading: new IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        )
      ),
      body: FutureBuilder<List<Category>>(
        future: futureCategories,
        builder:(context, snapshot) {
          if (snapshot.hasData) {
            return _buildHomePageList(snapshot.data);
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

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _filter.dispose();
    super.dispose();
  }

  // Parse json file in the background
  Future<List<Category>> fetchAllFromAssets(String assetPath) async {

    return dummyData();
  }

  List<Category> dummyData() {
    List<Category> categories = new List();
    Acronym acronym1 = new Acronym("AWS", "Amazon Web Services", 'Cloud Computing');
    Acronym acronym2 = new Acronym("S3", "Simple Storage System", 'Cloud Computing');
    Acronym acronym3 = new Acronym("GCP", "Google Cloud Platform", 'Cloud Computing');
    Acronym acronym4 = new Acronym("GCLB", "Google Cloud Load Balancer", 'Cloud Computing');
    Acronym acronym5 = new Acronym("AMI", "Amazon Machine Image", 'Cloud Computing');

    categories.add(new Category('CloudComputing', [acronym1, acronym2, acronym3, acronym4, acronym5]));

    Acronym acronym6 = new Acronym("AI", "Artificial Intelligence", 'AI');
    Acronym acronym7 = new Acronym("IMS", "Intelligent Maintenance Systems", 'AI');
    Acronym acronym8 = new Acronym("ML", "Machine Learning", 'AI');
    Acronym acronym9 = new Acronym("NI", "Natural Intelligence", 'AI');
    Acronym acronym10 = new Acronym("NLP", "Natural Language Processing", 'AI');
    Acronym acronym11 = new Acronym("CNN", "Convolutional Neural Network", 'AI');
    Acronym acronym12 = new Acronym("RNN", "Recurrent Neural Network", 'AI');
    Acronym acronym13 = new Acronym("CV", "Computer Vision", 'AI');
    Acronym acronym14 = new Acronym("HMD", "Head Mounted Display", 'AI');

    categories.add(new Category('AI', [acronym6, acronym7, acronym8, acronym9, acronym10, acronym11,
    acronym12, acronym13, acronym14]));


    setState(() {
//      categories.forEach((category) => allAcronyms.add(category.items));

      allAcronyms.add(acronym1);
      allAcronyms.add(acronym2);
      allAcronyms.add(acronym3);
      allAcronyms.add(acronym4);
      allAcronyms.add(acronym5);
      allAcronyms.add(acronym6);
      allAcronyms.add(acronym7);
      allAcronyms.add(acronym8);
      allAcronyms.add(acronym9);
      allAcronyms.add(acronym10);
      allAcronyms.add(acronym11);
      allAcronyms.add(acronym12);
      allAcronyms.add(acronym13);
      allAcronyms.add(acronym14);

      filteredAcronyms = allAcronyms;
    });

    return categories;
  }

  List<Category>  parseAllFromLocalJson() {
    // if no local data source return null;
    List<Category> categories = new List();

    return categories;
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = _closeIcon;
        this._appBarTitle = new TextField(
          textCapitalization: TextCapitalization.characters,
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: _searchIcon,
              hintText: 'Search for an acronym ...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Search Example' );
        /// reset filter
        filteredAcronyms = allAcronyms;
        _filter.clear();
      }
    });
  }

  // #docregion _buildHomePageList
  Widget _buildHomePageList(List<Category> categories) {

    if (!(_searchText.isEmpty)) {
      List tempAcronymList = new List<Acronym>();

      /// look for acronym
      for ( int i=0; i < filteredAcronyms.length; i++) {
        if (filteredAcronyms[i].title.toLowerCase().startsWith(_searchText.toLowerCase())) {
          tempAcronymList.add(filteredAcronyms[i]);
        }
      }
      filteredAcronyms = tempAcronymList;

      return ListView.builder(
          itemCount: allAcronyms == null ? 0: filteredAcronyms.length,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: /*1*/ (context, i) {

            return _buildSearchResultRow(filteredAcronyms[i]);
          });
    }

    return ListView.builder(
      itemCount: categories.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {

          return _buildCategoryRow(categories[i]);
        });
  }
  // #enddocregion _buildHomePageList

  // #docregion _buildSearchResultRow
  Widget _buildSearchResultRow(Acronym result) {

    return Card (
        child: ListTile(
          title: Text(
              result.title),
          subtitle: Text(
              result.description,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.blueGrey[600])),

    ));
  }
  // #enddocregion _buildSearchResultRow

  // #docregion _buildRow
  Widget _buildCategoryRow(Category category) {

    return Card(
        child: ListTile(
            title: Text(
                category.title),
            trailing: Icon(Icons.chevron_right),
            contentPadding: const EdgeInsets.all(8.0),
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


/// Category is immutable, ie widget build is called only once.
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
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
            subtitle: Text(
                acronym.description,
                style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.blueGrey[600])),

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