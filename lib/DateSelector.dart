import 'package:flutter/material.dart';

// Date picker
// The years only go from 2024 to 2028 because of the lifetime of a bankcard

class DateSelector extends StatefulWidget {
  double w;
  double h;
  String date = "";

  final Function(String) onDateSelected;
  final VoidCallback? onTap;

  DateSelector({required this.w, required this.h, required this.onDateSelected, required this.onTap});

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  String? selectedMonth;
  String? selectedYear;

  List<String> months = List.generate(12, (index) => (index + 1).toString());
  List<String> years = List.generate(5, (index) => (2024 + index).toString());

  void updString() {
    // Concatenate both strings to display it
    String monthPart = selectedMonth ?? "01";
    String yearPart = selectedYear ?? "24";

    if (monthPart.length == 1) {monthPart = "0$monthPart";}
    if (yearPart.length == 4) {yearPart = yearPart.substring(2);}
    widget.date = "$monthPart / $yearPart";
    widget.onDateSelected(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Expiration date'),
          const SizedBox(height: 10.0),
          Container(
            width: widget.w,
            height: 50,
            child: Row(
              children: [

                // Month selector
                Container(
                  width: 3*widget.w/5-5,
                  height: 45,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(200, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: const Color.fromARGB(50, 0, 0, 0),
                      width: 2.0,
                    ),
                  ),
                  child: DropdownButton<String>(
                    hint: const Text('Month'),
                    value: selectedMonth,
                    onTap: () {widget.onTap?.call();},
                    onChanged: (String? value) {
                      setState(() {
                        selectedMonth = value;
                        updString();
                      });
                    },
                    items: months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(width: 10.0),

                // Year selector
                Container(
                  width: 2*widget.w/5-5,
                  height: 45,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(200, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: const Color.fromARGB(50, 0, 0, 0),
                      width: 2.0,
                    ),
                  ),
                  child: DropdownButton<String>(
                    hint: const Text('Year'),
                    value: selectedYear,
                    onTap: () {widget.onTap?.call();},
                    onChanged: (String? value) {
                      setState(() {
                        selectedYear = value;
                        updString();
                      });
                    },
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}