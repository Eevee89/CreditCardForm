import 'package:flutter/material.dart';

// BackView of the card

class BackView extends StatefulWidget {
  double w;
  double h;
  double x;
  double y;
  String bank;
  String cvv;

  BackView({required this.w, required this.h, required this.x, required this.y,
    required this.bank, required this.cvv});

  @override
  _BackView createState() => _BackView();
}

class _BackView extends State<BackView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[

            // Magnetic band
            Positioned(
              top: widget.y+20,
              left: widget.x,
              child: Container(
                width: widget.w,
                height: 40,
                color: const Color.fromARGB(150, 0, 0, 0),
              ),
            ),

            // CVV label
            Positioned(
              top: widget.y+80,
              left: widget.x+widget.w-40,
              child: Container(
                  width: 20,
                  height: 15,
                  child: const Text(
                      "CVV",
                      style: TextStyle(color: Colors.white, fontSize: 10)
                  )
              ),
            ),

            Positioned(
              top: widget.y+95,
              left: widget.x+10,
              child: Container(
                width: widget.w-20,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color.fromARGB(50, 0, 0, 0),
                    width: 2.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.cvv,
                      //style: TextStyle(color: Colors.black, fontSize: 10),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),

            // Bank logo
            Positioned(
              top: widget.y+widget.h-70,
              left: widget.w+widget.x-115,
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(widget.bank),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ],
    );
  }
}