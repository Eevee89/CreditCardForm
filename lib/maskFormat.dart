import 'package:flutter/services.dart';

class MaskFormatter extends TextInputFormatter {
  final String bank;

  MaskFormatter({required this.bank});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String mask = getMaskForBank();
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    for (int i = 0; i < newValue.text.length; i++) {
      if (mask.length > i && mask[i] == '#') {
        newText.write(newValue.text[i]);
        if (selectionIndex > i) {
          selectionIndex++;
        }
      } else if (mask.length > i && mask[i] == ' ') {
        newText.write(' ');
        if (selectionIndex > i) {
          selectionIndex++;
        }
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  String getMaskForBank() {
    switch (bank) {
      case 'assets/amex.png':
        return '#### ###### #####';
      default:
        return '#### #### #### ####';
    }
  }
}

