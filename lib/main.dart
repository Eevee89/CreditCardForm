import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'DateSelector.dart';
import 'FrontView.dart';
import 'BackView.dart';
import 'maskFormat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double? width = MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Complex layout interaction'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double width; // Window width
  late double height; // Window height
  late double delta; // Gap between card and main container
  late double img_width; // Card width
  late double img_height; // Card heith
  late double img_x; // Card top pos
  late double img_y; // Card left pos
  late bool isVisible;
  late String number;
  late String name;
  late String date;
  late String bank;
  late String cvv;
  late int maxLength;
  late int current; // Current frame
  late List<Offset> positions;
  late List<double> widths;
  late List<double> heights;
  late String mask;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height - 200;

      // Defining all dimensions
      delta = width/15;
      img_width = width-100;
      img_height = 435*img_width/675;
      img_x = delta+20;
      img_y = 30;

      isVisible = true;
      current = 0;
      maxLength = 16;
      positions = [
        Offset(img_x+33, img_y+75),
        Offset(img_x+13, img_y+img_height-50),
        Offset(img_x+img_width-97, img_y+img_height-50),
      ];
      widths = [250, 200, 65];
      heights = [50, 45, 45];

      // Placeholders
      number = "#### #### #### ####";
      name = "Mandy Paplusse";
      bank = "assets/visa.png";
      date = "01 / 24";
      cvv = "000";

      setState(() {});
    });
  }

  void updBank({required number})
  // Update the Bank logo according to the card number
  {
    if (RegExp(r'^3[47]').hasMatch(number))
      {
        bank = "assets/amex.png";
      }

    else if (RegExp(r'^6011').hasMatch(number) ||
        RegExp(r'^64[4-9]').hasMatch(number))
    {
      bank = "assets/discover.png";
    }

    else if (RegExp(r'^36').hasMatch(number))
    {
      bank = "assets/dinersclub.png";
    }

    else if (RegExp(r'^3528').hasMatch(number) ||
        RegExp(r'^3529').hasMatch(number) ||
        RegExp(r'^35[3-8][0-9]').hasMatch(number))
    {
      bank = "assets/jcb.png";
    }

    else if (RegExp(r'^5[15]').hasMatch(number) ||
        RegExp(r'(?:\d[ -]*){4}(?:22[2-9]\d|23\d\d|24\d\d|25\d\d|26\d\d|27[01]\d)$').hasMatch(number))
    {
      bank = "assets/mastercard.png";
    }

    else if (RegExp(r'^65').hasMatch(number) ||
        RegExp(r'^9792').hasMatch(number))
    {
      bank = "assets/troy.png";
    }

    else if (RegExp(r'62[0-9\s]*$').hasMatch(number))
    {
      bank = "assets/unionpay.png";
    }

    else
    {
      bank = "assets/visa.png";
    }
  }

  bool Luhn({required number})
  // Verify if the number is correct
  {
    int res = 0;
    for (int i = number.Length-2; i>=0; i--)
      {
        res += 2*int.parse(number[i]) %9;
      }
    return res%10 == 0;
  }

  void _showAlert(BuildContext context, String header, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(header),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String format(String text, String bank) {
    String res = "";
    if (bank != "assets/amex.png"){
      if (text.length < 16)
        {
          for (int i=0; i<text.length; i++){
            res += text[i];
            if (i%4 == 3) { res += " ";}
          }
          for (int i=text.length; i<16; i++){
            res += "#";
            if (res.length == 4 || res.length == 9 || res.length == 14) { res += " ";}
          }
        }

      else
      {
        text = text.substring(0, 16);
        for (int i=0; i<text.length; i++){
          res += text[i];
          if (i%4 == 3) { res += " ";}
        }
        for (int i=text.length; i<16; i++){
          res += "#";
          if (res.length == 4 || res.length == 9 || res.length == 14) { res += " ";}
        }
      }
    }

    else {
      if (text.length <= 15)
        {
          for (int i=0; i<text.length; i++){
            res += text[i];
            if (i == 3 || i == 9) { res += " ";}
          }
          for (int i=text.length; i<15; i++){
            res += "#";
            if (res.length == 4 || res.length == 11) { res += " ";}
          }
        }
      else
      {
        text = text.substring(0, 15);
        for (int i=0; i<text.length; i++){
          res += text[i];
          if (i == 3 || i == 9) { res += " ";}
        }
        for (int i=text.length; i<15; i++){
          res += "#";
          if (res.length == 4 || res.length == 11) { res += " ";}
        }
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[

          // Main Form Widget
          Positioned(
            top: img_y+2*img_height/3,
            left: img_x-delta,
            child: Container(
              width: img_width+2*delta,
              height: height-30-(img_y+2*img_height/3),
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(50, 0, 0, 0),
                  width: 2.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  // TextInput for the card number
                  Container(
                    width: img_width+2*delta-40,
                    height: 50,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                        MaskFormatter(bank: bank)
                      ],
                      onTap: () {
                        setState(() {
                          isVisible = true;
                          current = 0;
                        });
                      },
                      onChanged: (text) {
                        setState(() {
                          if (text.length <= maxLength)
                            {
                              //number = format(text);
                              number = text;
                            }
                          updBank(number: number);
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your card number',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20
                  ),

                  // TextInput for the card holder
                  Container(
                    width: img_width+2*delta-40,
                    height: 50,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z\s{-}{'}]*$")),
                      ],
                      onTap: () {
                        setState(() {
                          isVisible = true;
                          current = 1;
                        });
                      },
                      onChanged: (text) {
                        setState(() {
                          if (text.length < 20) {
                            name = text.toUpperCase();
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your name',
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 20
                  ),

                  Container(
                    width: img_width+2*delta-40,
                    height: 120,
                    child:
                        // Row with the date selector and the CVV input
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        DateSelector(
                          w: img_width+2*delta-150,
                          h: img_height,
                          onTap: () {
                            setState(() {
                              current = 2;
                            });
                          },
                          onDateSelected: (date) {
                            setState(() {
                              this.date = date;
                            });
                          },
                        ),

                        // Text input for the CVV
                        Container(
                          width: 70,
                          height: 45,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                            ],
                            onTap: () {
                              setState(() {
                                isVisible = false;
                              });
                            },
                            onChanged: (text) {
                              setState(() {
                                if (text.length < 4)
                                {
                                  cvv = text;
                                }
                              });
                            },
                            onEditingComplete: ()
                            {
                              setState(() {
                                isVisible = true;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVV',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                      height: 20
                  ),

                  // Button to submit
                  Container(
                    width: img_width+2*delta-40,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isVisible = true;
                        });
                        if (!RegExp(r'[0-9]{4}\s[0-9]{4}\s[0-9]{4}\s[0-9]{4}').hasMatch(number))
                          {
                            _showAlert(context, "Warning", "Invalid number length");
                          }
                        else if (!Luhn(number: number))
                          {
                            _showAlert(context, "Warning", "Invalid card number");
                          }
                        else
                        {
                          _showAlert(context, "Card saved", 'Welcome $name\nCard number : $number\nExpires in : $date');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),

                  const SizedBox(
                      height: 20
                  ),
                ],
              ),
            ),
          ),

          // Card background
          Positioned(
            top: img_y,
            left: img_x,
            child: Container(
              width: img_width,
              height: img_height,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: AssetImage('assets/6.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // FrontView of the card
          Visibility(
            visible: isVisible,
            child: FrontView(w: img_width, h: img_height, x: img_x, y: img_y,
              bank: bank, number: number, name: name, date: date,),
          ),

          // BackView of the card
          Visibility(
            visible: !isVisible,
            child: BackView(w: img_width, h: img_height, x: img_x, y: img_y, bank: bank, cvv: cvv,),
          ),

          // Frame to highlight the currently updated slot
          Visibility(
            visible: isVisible,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: widths[current],
              height: heights[current],
              margin: EdgeInsets.fromLTRB(
                positions[current].dx,
                positions[current].dy,
                0.0,
                0.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(200, 255, 255, 255),
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}