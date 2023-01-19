import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';

/*
* 참고 : https://pub.dev/packages/dropdown_button2
* */

//todo : isExpand 했을 때 모양 바꾸기

class SrDropdownBox extends StatelessWidget {
  final List<Color>? dropdownIconColors;
  final double? dropdownIconSize;
  final String hint;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;

  const SrDropdownBox(
      {required this.hint,
        required this.dropdownItems,
        required this.onChanged,
        required this.dropdownIconSize,
        this.dropdownIconColors,
        this.selectedItemBuilder,
        this.hintAlignment,
        this.valueAlignment,
        this.buttonHeight,
        this.buttonWidth,
        this.buttonPadding,
        this.buttonDecoration,
        this.buttonElevation,
        this.icon,
        this.iconSize,
        this.iconEnabledColor,
        this.iconDisabledColor,
        this.itemHeight,
        this.itemPadding,
        this.dropdownHeight,
        this.dropdownWidth,
        this.dropdownPadding,
        this.dropdownDecoration,
        this.dropdownElevation,
        this.scrollbarRadius,
        this.scrollbarThickness,
        this.scrollbarAlwaysShow,
        this.offset,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: SrColors.black,
            ),
          ),
        ),
        items: dropdownItems.asMap().entries
            .map((entry) => DropdownMenuItem<String>(
          value: entry.value,
          child: Column(children: <Widget>[
            const SizedBox(height: 10, width: 160),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 17)),
                Icon(
                  Icons.circle,
                  size: dropdownIconSize,
                  color: dropdownIconColors?[entry.key],
                ),
                const Padding(padding: EdgeInsets.only(right: 7)),
                Text(
                  entry.value,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11, width: 160),
            Container(height: 1, width: 160, color: SrColors.gray,)
          ],),
        ))
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        icon: icon ??
            SvgPicture.asset('assets/category_arrow.svg',
                width: 16, height: 16),
        iconOnClick: icon ?? SvgPicture.asset('assets/arrow_up.svg', width: 16, height: 16),
        iconSize: iconSize ?? 16,
        iconEnabledColor: iconEnabledColor,
        iconDisabledColor: SrColors.gray2,
        buttonHeight: buttonHeight ?? 44,
        buttonWidth: buttonWidth ?? 160,
        buttonPadding:
        buttonPadding ?? const EdgeInsets.only(left: 19, right: 14),
        buttonDecoration: buttonDecoration ??
            BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(22)),
              border: Border.all(
                width: 1,
                color: SrColors.gray1,
              ),
            ),
        buttonElevation: buttonElevation,
        itemHeight: 40,
        itemPadding: itemPadding ?? EdgeInsets.zero,
        //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
        dropdownMaxHeight: 310,
        dropdownWidth: 160,
        dropdownPadding: dropdownPadding ?? EdgeInsets.zero,
        dropdownDecoration: dropdownDecoration ??
            BoxDecoration(
              border: Border.all(color: SrColors.gray1),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22), bottomRight:Radius.circular(22)),
            ),
        dropdownElevation: 0,
        scrollbarRadius: scrollbarRadius ?? const Radius.circular(40),
        scrollbarThickness: scrollbarThickness,
        scrollbarAlwaysShow: scrollbarAlwaysShow,
        //Null or Offset(0, 0) will open just under the button. You can edit as you want.
        offset: offset,
        dropdownOverButton: false, //Default is false to show menu below button
      ),
    );
  }

  dropDownOpen() {}
}