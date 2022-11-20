import 'package:flutter/material.dart';

class TopRightBadge extends StatelessWidget {
  const TopRightBadge({
    super.key,
    required this.child,
    required this.data,
    this.color,
  });

  final Widget child;
  final Object data;
  final Color? color;
  
  @override
  Widget build(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children:[
        child,
        Positioned(
          right: 4,
          top: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? Colors.red,
            ),
            constraints: const BoxConstraints (
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              data.toString(),
              textAlign : TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
