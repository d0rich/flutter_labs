import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpu_mobile_labs/support/lab9/GithubRepository.dart';

class SearchResultsWidget extends StatelessWidget{
  final List<GithubRep> results;
  final Function(GithubRep rep) pickRep;

  SearchResultsWidget({
    Key? key,
    required this.results,
    required this.pickRep
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: this.results.length,
        itemBuilder: (BuildContext context, int index){
          return OutlinedButton(
            onPressed: this.pickRep(this.results[index]),
            child: Container(
                height: 50,
                child: Text(this.results[index].owner + '/' +this.results[index].name)
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

}