import 'package:flutter/material.dart';

// Frame to highlight which field is being updated

class SwitchView extends StatefulWidget {
  double w;
  double h;
  double x;
  double y;

  SwitchView({required this.w, required this.h, required this.x, required this.y,});


  @override
  _SwitchView createState() => _SwitchView();
}

class _SwitchView extends State<SwitchView>{
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: widget.y,
        left: widget.x,
        child: Container(
          width: widget.w,
          height: widget.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: const Color.fromARGB(200, 255, 255, 255),
                width: 2.0,
              ),
          ),
        ),
    );
  }
}