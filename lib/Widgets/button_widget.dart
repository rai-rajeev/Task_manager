import 'package:flutter/cupertino.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;
  const ButtonWidget({Key? key,
    required this.color,
    required this.text,
    required this.textColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      alignment: AlignmentDirectional.center,
      height: MediaQuery.of(context).size.height/14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(48)

      ),
      child: Text(text,style: TextStyle(
        fontSize: 20,color: textColor
      ),),
    );
  }
}
