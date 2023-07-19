import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final double borderRadius;
  final int? maxlines;
  final bool readOnly;
  const TextFieldWidget({Key? key, required this.textController, required this.hintText, required this.borderRadius, this.maxlines=1, this.readOnly=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextField(
      readOnly: readOnly,
      maxLines: maxlines,
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFedf0f8),
        hintText: hintText,
        focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
                color: Colors.white,
                width: 1
            )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1
          )

        )
      ),

    );
  }
}
