import 'package:flutter/material.dart';
import 'package:get/get.dart';

// TODO: Maybe we can open [showModalBottomSheet] with search ?
class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              hintText: 'Search'.tr,// Added this
              contentPadding: EdgeInsets.all(1),  // Added this
            ),
          )
        ],
      ),
    );
  }
}
