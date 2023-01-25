import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SrAttachPiture extends StatefulWidget {
  const SrAttachPiture({Key? key}) : super(key: key);

  @override
  State<SrAttachPiture> createState() => _SrAttachPitureState();
}

class _SrAttachPitureState extends State<SrAttachPiture> {

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children:[
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  var image = await _picker.pickImage(source: ImageSource.gallery);
                },
                child: DottedBorder(
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
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const Image(
              image: NetworkImage('https://picsum.photos/200'), width: 92, height: 92,),
            ),
        ],
      ),

    );
  }
}