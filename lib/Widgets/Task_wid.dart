import 'package:flutter/cupertino.dart';

class TaskContainer extends StatelessWidget {
  final String text;
  final Color color;
  const TaskContainer({Key? key, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      alignment: Alignment.center,
      width:double.maxFinite,
      height:MediaQuery.of(context).size.height/14,
      decoration: BoxDecoration(
        color: const Color(0xFFedf0f8),
        borderRadius: BorderRadius.circular(0),

      ),
      child: Text(text,style:TextStyle(
        fontSize: 20,
        color: color,
      ),),
    );
  }
}
