import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tpu_mobile_labs/support/lab9/GithubRepository.dart';

class SearchGithubWidget extends StatefulWidget {

  final Function(List<GithubRep> results) returnResults;

  SearchGithubWidget({
    Key? key,
    required this.returnResults
  }) : super(key: key);

  @override
  _SearchGithubWidgetState createState() => _SearchGithubWidgetState();
}

class _SearchGithubWidgetState extends State<SearchGithubWidget>{
  late TextEditingController _searchController = TextEditingController();

  searchGithub() async {
    http.Response response = await http
        .get(Uri.parse('https://api.github.com/search/repositories?q='+_searchController.text+'&page=1&per_page=15'));
    Map<String, dynamic> rawResults = jsonDecode(response.body);
    List<GithubRep> results = [];
    for(final item in rawResults['items']){
      results.add(GithubRep.fromJson(item));
    }
    this.widget.returnResults(results)();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 200,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search GitHub',
              ),
            )
          ),
          OutlinedButton(
              onPressed: searchGithub,
              child: Icon(Icons.search)
          ),
        ],
      ),
    );
  }

}