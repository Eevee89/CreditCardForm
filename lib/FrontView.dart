import 'package:flutter/material.dart';

// FrontView of the card

class FrontView extends StatefulWidget {
  double w;
  double h;
  double x;
  double y;
  String bank;
  String number;
  String name;
  String date;

  FrontView({required this.w, required this.h, required this.x, required this.y,
    required this.bank, required this.number, required this.name, required this.date,});

  @override
  _FrontView createState() => _FrontView();
}

class _FrontView extends State<FrontView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[

            // Chip image
            Positioned(
              top: widget.y+15,
              left: widget.x+15,
              child: Container(
                width: 40.4,
                height: 32.8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/chip.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Bank logo
            Positioned(
              top: widget.y+15,
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

            // Card number label
            Positioned(
              top: widget.y+80,
              left: widget.x+40,
              child: Container(
                width: 70,
                height: 15,
                child: const Text(
                  'Card number',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),

            Positioned(
              top: widget.y+95,
              left: widget.x+40,
              child: Container(
                width: 300,
                height: 50,
                child: Text(
                  widget.number,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            // Card holder label
            Positioned(
              top: widget.y+widget.h-45,
              left: widget.x+20,
              child: Container(
                width: 70,
                height: 15,
                child: const Text(
                  'Card holder',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),

            Positioned(
              top: widget.y+widget.h-30,
              left: widget.x+20,
              child: Container(
                width: 200,
                height: 20,
                child: Text(
                  widget.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),


            // Expiration date label
            Positioned(
              top: widget.y+widget.h-45,
              left: widget.x+widget.w-90,
              child: Container(
                width: 70,
                height: 15,
                child: const Text(
                  'Expiration date',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),

            Positioned(
              top: widget.y+widget.h-30,
              left: widget.x+widget.w-88,
              child: Container(
                width: 70,
                height: 20,
                child: Text(
                  widget.date,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
    );
  }
}