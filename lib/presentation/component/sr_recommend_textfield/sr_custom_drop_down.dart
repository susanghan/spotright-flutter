import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

SrCustomDropdown srCustomDropdown = SrCustomDropdown();

class SrCustomDropdown {
  OverlayEntry inputRecommendation(
      {required LayerLink layerLink,
      required TextEditingController controller,
      required Function onPressed,
      required margin,
      required inputList,
      required Function inputListChanged}) {
    final inputListLength = inputList.length;

    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 49),
          child: Container(
            margin: margin,
            height: inputListLength == 0 ? 0 : (45.0 * inputListLength) + 6,
            decoration: BoxDecoration(
                border: Border.all(color: SrColors.gray3),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: SrColors.black.withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
                color: SrColors.white),
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 2),
              itemCount: inputList.length,
              itemBuilder: (context, index) {
                inputListChanged();
                return CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  pressedOpacity: 1,
                  minSize: 45,
                  onPressed: () {
                    controller.text = inputList.elementAt(index);
                    onPressed();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${inputList.elementAt(index)}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
