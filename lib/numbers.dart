import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController textController;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10.0,
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          var cursorPosition = textController.selection.base.offset;

          if (cursorPosition == -1) {
            textController.text += number.toString();
          }

          String suffixText = textController.text.substring(cursorPosition);

          String specialChars = number.toString();
          int length = specialChars.length;

          String pref = textController.text.substring(0, cursorPosition);

          textController.text = pref + specialChars + suffixText;

          textController.selection = TextSelection(
            baseOffset: cursorPosition + length,
            extentOffset: cursorPosition + length,
          );
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}