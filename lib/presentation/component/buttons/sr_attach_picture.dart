import 'dart:ffi';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:spotright/presentation/common/colors.dart';

class SrAttachPiture extends StatefulWidget {
  const SrAttachPiture({Key? key}) : super(key: key);

  @override
  State<SrAttachPiture> createState() => _SrAttachPitureState();
}

typedef OnPickImageCallback = void Function(double? maxWidth, double? maxHeight, int? quality);

class _SrAttachPitureState extends State<SrAttachPiture> {
  final ImagePicker _picker = ImagePicker();
  final Color _clickedColor = SrColors.gray1.withOpacity(0.7);
  dynamic _pickImageError;

  List<XFile> _imageFileList = [];
  List<bool> _isImgaeFileClicked = List.filled(5, false);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 92,
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                _onAttachButtonPressed(ImageSource.gallery, context: context);
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(20),
                dashPattern: [5, 5],
                child: Container(
                  width: 90,
                  height: 90,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/camera.svg"),
                      Text("${_imageFileList.length}/5"),
                    ],
                  ),
                ),
              ),
            ),
            ...?_AttachPictures(),
          ],
        ),
      ),
    );
  }

  Widget _AttachPicture(int index, XFile imageFile) {
    return Row(children: [
      const SizedBox(height: 92, width: 8,),
      GestureDetector(
        onTap: (){
          setState(() {
            _isImgaeFileClicked[index] ? _imageFileList.removeAt(index) : {_isImgaeFileClicked = List.filled(5, false), _isImgaeFileClicked[index] = true};
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children:[
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(imageFile.path),
                  width: 92,
                  height: 92,
                  cacheWidth: 200,
                )),
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 92,
                  width: 92,
                  decoration: BoxDecoration(color: _isImgaeFileClicked[index] ? _clickedColor : null, borderRadius: BorderRadius.circular(20), border: Border.all(color: SrColors.gray3)),
                ),
              )
            ),
            Align(
              child: _isImgaeFileClicked[index] ? SvgPicture.asset("assets/cross_mark.svg", width: 24, height: 24, color: SrColors.white,) : null
    ),
          ]
        ),
      )
    ]);
  }

  List<Widget>? _AttachPictures() {
    return _imageFileList.asMap().entries.map((e) => _AttachPicture(e.key, e.value)).toList();
  }

  Future<void> _onAttachButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final List<XFile> pickedFileList = await _picker.pickMultiImage();
      setState(() {
        _imageFileList = [...pickedFileList, ..._imageFileList];
        _imageFileList.length < 6
            ? {_imageFileList = _imageFileList, _isImgaeFileClicked = List.filled(5, false)}
            : _imageFileList = _imageFileList.reversed.take(5).toList();
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }
}
