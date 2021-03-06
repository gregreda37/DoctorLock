import 'package:doc_lock/models/patient.dart';
import 'package:doc_lock/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Patient>>(context) ?? [];


    return ListView.builder(
      
      itemCount: brews.length,
      itemBuilder: (context, index){
        return BrewTile(
          brew: brews[index],
          );
      },
      
    );
  }
}