import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskFormatter extends TextInputFormatter {
  final String bank;
  MaskFormatter({required this.bank});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
  )
  {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength == 4 || newTextLength == 9 || newTextLength == 14) {
      newText.write(' ');
      if (newValue.selection.end >= 1)
        selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}