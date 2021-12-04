import 'package:flutter/cupertino.dart';
import 'package:tpu_mobile_labs/support/lab9/GithubRepository.dart';

class GithubDetailsWidget extends StatelessWidget{
  final GithubRep? rep;

  GithubDetailsWidget({Key? key, required this.rep}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: rep != null,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(rep?.ownerImage ?? '', width: 30, height: 30,),
                  ),
                  Text(rep?.owner ?? '')
                ],
              ),
              Text(rep?.name ?? ''),
              Text(rep?.description ?? '')
            ],
          ),
        )
    );
  }


}