import 'package:cocktails_app/Cocktail.dart';
import 'package:cocktails_app/CocktailDetail.dart';
import 'package:cocktails_app/DataSource.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() async {
  Future<List<Cocktail>> futureOfList = DataSource().fetchCocktailData();
  List<Cocktail> list = await futureOfList;
  runApp(MyApp(list: list));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.list}) : super(key: key);
  List<Cocktail> list;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
              'Cocktails App',
            style: const TextStyle(
               color: Colors.black
            ),
          ),
        ),
        body: Center(
          child: ListSearch(cocktails: list),
        ),
      )
    );
  }
}

class ListSearch extends StatefulWidget {
  const ListSearch({Key? key, required this.cocktails}) : super(key: key);
  final List<Cocktail> cocktails;

  @override
  ListSearchState createState() => ListSearchState(cocktails: cocktails);
}

class ListSearchState extends State<ListSearch> {
  List<Cocktail> cocktails;
  final TextEditingController _textController = TextEditingController();
  List<Cocktail> newDataList = [];

  ListSearchState({required this.cocktails}) {
    newDataList = cocktails;
  }

  onItemChanged(String value) {   // This is for the search bar for the list so that it can update continuously.
    setState(() {
      newDataList = cocktails.where((element) => element.name.toLowerCase()
          .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Search Here...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: newDataList.length,
              itemBuilder: (BuildContext context, int index) {
                newDataList.sort((a, b) => a.name.compareTo(b.name));   //   Sorting the list alphabetically.
                return SizedBox(
                  height: 80,
                  child: Card(
                    child: ListTile(
                      title: Text(newDataList[index].name),
                      subtitle: newDataList[index].category == null ? null : Text(newDataList[index].category.toString()),
                      leading: SizedBox(
                        child: Image.asset(
                            newDataList[index].image,
                            width: 50,
                            height: 50),
                      ),
                      onTap: (){       // On tap of one of the list tiles to display the CocktailDetails.dart of that cocktail that has been tapped.
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CocktailDetail(cocktailData: newDataList[index],)));
                      },
                    ),
                    color: Colors.white,
                    margin: const EdgeInsets.all(5),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}