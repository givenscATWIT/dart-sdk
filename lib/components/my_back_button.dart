import 'package:flutter/material.dart';

class MyBackButton extends StatefulWidget {
  const MyBackButton({super.key});

  @override
  Widget build (BuildContext context){
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decorating: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ), // BoxDecoration
        padding: EdgeInsets.all(10),
        child: const Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ), // Container
    ); // GestureDetector

  }
}
