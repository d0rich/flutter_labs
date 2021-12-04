import 'package:flutter/material.dart';
import 'package:tpu_mobile_labs/support/lab9/GithubDetailsWidget.dart';
import 'package:tpu_mobile_labs/support/lab9/GithubRepository.dart';
import 'dart:math';

import 'package:tpu_mobile_labs/support/lab9/SearchGithubWidget.dart';
import 'package:tpu_mobile_labs/support/lab9/SearchResultsWidget.dart';

class Lab9 extends StatefulWidget {
  Lab9({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab9State createState() => _Lab9State();
}

class _Lab9State extends State<Lab9> {
  late List<GithubRep> _searchResults = [];
  late GithubRep? _rep = null;

  displayResults(List<GithubRep> results){
    return () => setState((){
      _searchResults = results;
    });
  }

  showDetails(GithubRep rep){
    return () => setState((){
      _rep = rep;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SearchGithubWidget(returnResults: displayResults),
            GithubDetailsWidget(rep: _rep),
            SearchResultsWidget(results: _searchResults, pickRep: showDetails)
          ],
        ),
      ),
    );
  }
}
