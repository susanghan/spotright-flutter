import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SrAttachPiture extends StatefulWidget {
  const SrAttachPiture({Key? key}) : super(key: key);

  @override
  State<SrAttachPiture> createState() => _SrAttachPitureState();
}

class _SrAttachPitureState extends State<SrAttachPiture> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(20),
            dashPattern: [5, 5],
            child: Container(
              width: 92,
              height: 92,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/camera.svg"),
                  Text("0/5"),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}