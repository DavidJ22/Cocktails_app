import 'package:flutter/material.dart';
import 'package:cocktails_app/Cocktail.dart';


class CocktailDetail extends StatelessWidget {
  final Cocktail cocktailData;
  const CocktailDetail({Key? key, required this.cocktailData}) : super(key: key);

//Building the CocktailDetail page, displaying the cocktail glass image, displaying the cocktail name in the app bar
// displaying the category, garnish, ingredients and preparation
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text(
            cocktailData.name,      // So the name of the cocktail is shown in the app bar.
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(48),
            child:Image.asset(   //   Inserting the image
              cocktailData.image,
              width: 200,
              height: 200,
            ),
          ),
          Text('Glass type: ${cocktailData.getGlassType()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)), //    Displaying data from a single cocktail and making them centerd on the page.
          Container(
            padding: EdgeInsets.only(top: 8,bottom: 8),
            alignment: Alignment.center,
            child: cocktailData.category != null ? Text('Category: ${cocktailData.category.toString()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)) : Container(),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 6),
            alignment: Alignment.center,
            child: cocktailData.garnish != null ? Text('Garnish: ${cocktailData.garnish.toString()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)) : Container(),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            alignment: Alignment.center,
            child: Text('Ingredients:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ // For listing every ingredient and amount for the cocktail.
              for(var item in cocktailData.ingredients ) Text('${item.amount} Cl ${item.ingredient == null ? item.special.toString() : item.ingredient.toString()}',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold) ,),
            ],
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 18, left: 18,top: 14,bottom: 8),
            child: cocktailData.preparation != null ? Text(
              'Preparation method: ${cocktailData.preparation.toString()}',
              textAlign: TextAlign.center
                ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)
            ) : Container(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
