import 'dart:ffi';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:spotright/presentation/common/colors.dart';

import '../../page/register_spot/register_spot_controller.dart';

class SrAttachPiture extends StatefulWidget {
  SrAttachPiture({Key? key}) : super(key: key);


  @override
  State<SrAttachPiture> createState() => _SrAttachPitureState();
}

typedef OnPickImageCallback = void Function(double? maxWidth, double? maxHeight, int? quality);

class _SrAttachPitureState extends State<SrAttachPiture> {
  final RegisterSpotController registerSpotController = Get.find();

  final ImagePicker _picker = ImagePicker();
  final Color _clickedColor = SrColors.gray1.withOpacity(0.7);
  dynamic _pickImageError;

  List<XFile> imageFileList = [];
  bool hasInitImage = false;
  List<bool> _isImgaeFileClicked = List.filled(5, false);

  @override
  void initState() {
    if(registerSpotController.pageMode == PageMode.edit){
      print("initState : ${registerSpotController.imageFilePath.value}");
      if(registerSpotController.imageFilePath.value.isNotEmpty){
        hasInitImage = true;
      }
      _AttachPictures();
    }
    super.initState();
  }


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
                      Text("${registerSpotController.imageFilePath.length}/5"),
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

  Widget _AttachPicture(int index, String imageFile) {
    return Row(children: [
      const SizedBox(height: 92, width: 8,),
      GestureDetector(
        onTap: (){
          setState(() {
            _isImgaeFileClicked[index] ? registerSpotController.imageFilePath.value.removeAt(index) : {_isImgaeFileClicked = List.filled(5, false), _isImgaeFileClicked[index] = true};
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children:[
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: imageFile.contains("http") ? Image.network(imageFile) : Image.file(
                  File(imageFile),
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
    return registerSpotController.imageFilePath.value.asMap().entries.map((e) => _AttachPicture(e.key, e.value)).toList();
  }

  Future<void> _onAttachButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final List<XFile> pickedFileList = await _picker.pickMultiImage();
      setState(() {
        int _insertIndex = 0;

        while(registerSpotController.imageFilePath.length < 5 && pickedFileList.length > _insertIndex){
            registerSpotController.imageFilePath.insert(_insertIndex, pickedFileList[_insertIndex].path);
            _insertIndex += 1;
        }

        _isImgaeFileClicked = List.filled(5, false);


        /*
        switch(registerSpotController.pageMode){
          case PageMode.add : {
            imageFileList = [...pickedFileList, ...imageFileList];
            imageFileList.length < 6
                ? {imageFileList = imageFileList, _isImgaeFileClicked = List.filled(5, false), }
                : imageFileList = imageFileList.reversed.take(5).toList();

            registerSpotController.imageFilePath.value = [];
            imageFileList.forEach((element) { registerSpotController.imageFilePath.add(element.path); });
          }
          break;
          case PageMode.edit : {
              registerSpotController.imageFilePath.length + pickedFileList.length < 6
                  ? {pickedFileList.reversed.forEach((element) {registerSpotController.imageFilePath.insert(0, element.path); _isImgaeFileClicked = List.filled(5, false);})}
                  : {};
          }
        }*/

        //hasInitImage ? hasInitImage = false : registerSpotController.imageFilePath.value = [];
        //imageFileList.forEach((element) { registerSpotController.imageFilePath.value.insert(0, element.path); });

      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }
}
