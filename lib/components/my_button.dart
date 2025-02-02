import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
    final String text;
    final void Function()? onTap;

    const Mybutton({
        super.key,
        required this.text,
        required this.onTap,
        });

    @override
    Widget build(BuildContext context){
        return GestureDetector(
            onTap: onTap,
            child: Container(
                decoration BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                ), // BoxDecoration
                padding:const EdgeInsets.all(25),
                child: Center(
                    child: Text(
                        text,
                        style: const TextStyle(
                            fontWeight: Fontweight.bold,
                            fontSized: 16,
                        ), // TextStyle
                    ), // Text
                ), // Center
            ), // Container
        ); // GestureDetector
    }
}