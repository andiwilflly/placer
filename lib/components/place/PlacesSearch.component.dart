import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:placer/models/store.dart';

class PlacesSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return search(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return search(query);
  }

  Widget search(String query) {
    final names = store.places.all.getValues().map((place) {
      return place['name'][store.lang.lang.value];
    }).toList();

    final fuse =
        Fuzzy(names, options: FuzzyOptions(findAllMatches: true, tokenize: false, threshold: 0.5));

    final results = query.length < 3 ? [] : fuse.search(query);

    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final placeIndex = results[index].matches[0].arrayIndex;
          final place = store.places.all.getValues().toList();
          print(place);
          return ListTile(
            title: Text('Title'),
          );
        });
  }
}
