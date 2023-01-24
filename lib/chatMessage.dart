import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Expanded(
            child: sender == 'user'
                ? Text(text)
                    .text
                    .subtitle2(context)
                    .bold
                    .make()
                    .box
                    .rounded
                    .alignCenterRight
                    .py12
                    .px12
                    .height(50)
                    .color(Color.fromARGB(255, 233, 185, 62)!)
                    .make()
                    .p12()
                : Text(text)
                    .text
                    .subtitle1(context)
                    .make()
                    .box
                    .rounded
                    .alignCenterLeft
                    .px12
                    .color(Color.fromARGB(255, 117, 179, 103))
                    .make()
                    .p20()
            // text.trim().text.bodyText1(context).make().px8().py2(),
            ),
      
        if (sender != 'user') Icon(Icons.smart_toy_rounded).iconSize(50).iconColor(Color.fromARGB(255, 36, 123, 16))
      ],
    );
  }
}





  // if (sender == 'user')
        //   Text(sender[0].toUpperCase())
        //       .text
        //       .subtitle1(context)
        //       .make()
        //       .box
        //       .color(sender == "user" ? Vx.cyan400 : Vx.green400)
        //       .p16
        //       .roundedFull
        //       .alignCenter
        //       .makeCentered(),