import 'package:flutter/material.dart';

class MyListTile extends StatefulWidget {
  final String title;
  final String subTitle;
  const MyListTile({
    super.key,
    required this.title,
    required this.subTitle
  });

  @override
  Widget build (BuildContext context){
    return Padding(
      padding: const EdgeInsects.only(left: 20, right: 20, bottom: 10), // EdgeInsects.only
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ), // BoxDecoration
        child: ListTile (
          title: Text(title),
          subTitle: Text(subTitle),
          subtitle: Text(
            userEmail,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ); // ListTile
      )
    ), // Padding
  }
}


