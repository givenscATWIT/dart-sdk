import 'package:flutter/material.dart';

class PostButton extends StatefulWidget {
  final void Function()? onTap;
  const PostButton({super.key, required this.onTap});

  @override
  Widget build (BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
          borderRadius: borderRadius.circular(12),
        ),
        padding: const EdgeInsects.all(16),
        margin: const EdgeInsects.only(left: 10),
        child: Center(
          child: Icon(
            Icons.done,
            color: Theme.of(context).colorScheme.primary,
          ), // Icon
        ), // Center
      )
    ); // Container
  }
}
