/**
 *
 * Small app written using Flutter to browse and search acronyms based on categories.
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:acronymapp/model/acronym_model.dart';
import 'package:acronymapp/services/acronym_service.dart';


void main() => runApp(MyApp());


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

  Future<CategoryList> getCategories;

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
    getCategories = loadAcronyms('assets/acronyms.json');
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
    body: FutureBuilder<CategoryList>(
      future: getCategories,
      builder:(context, snapshot) {
        if (snapshot.hasData) {
          return _buildHomePage(snapshot.data);
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

  // #docregion _buildHomePage
  Widget _buildHomePage(CategoryList categories) {

    allAcronyms.clear();
    filteredAcronyms.clear();

    categories.categories.forEach((category) => allAcronyms.addAll(category.items));
    filteredAcronyms = allAcronyms;


    if (_searchText.isNotEmpty) {
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
        itemCount: categories.categories.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {

          return _buildCategoryRow(categories.categories[i]);
        });
  }
  // #enddocregion _buildHomePage

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