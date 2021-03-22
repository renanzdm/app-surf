import 'package:flutter/material.dart';

class SearchHelper extends SearchDelegate {
  String selecteResult = '';
  final List<String> list;
  List<String> recentResults = ['Recente1', 'Recente2', 'Recente3'];

  SearchHelper(this.list);

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              query = '';
            })
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );

  @override
  Widget buildResults(BuildContext context) => Container(
        child: Container(
          height: 200,
          child: Center(
            child: Text(selecteResult),
          ),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentResults
        : suggestionList.addAll(
            list.where(
              (element) => element.contains(query),
            ),
          );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          suggestionList[index],
        ),
        onTap: () {
          selecteResult = suggestionList[index];
          showResults(context);
        },
      ),
    );
  }
}
