import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrDropdownButton extends StatefulWidget {
  SrDropdownButton({Key? key, required this.hint, required this.dropdownItems, required this.onChanged, required this.hasIcon, this.dropdownIconColors, required this.isRequired}) : super(key: key);
  
  String hint; //카테고리 제몰
  final List<String> dropdownItems; //버튼 누르면 나오는 아이템들 List
  final ValueChanged<String?>? onChanged; //아이템 선택했을 때 실행되는 함수
  final bool hasIcon; //드롭다운 아이템이 앞에 아이콘을 갖고 있는지
  bool isRequired; //필수 항목인지(글자 표시됨)
  List<Color>? dropdownIconColors; //드롭다운 아이템이 갖고 있는 아이콘의 색들

  DropdownButtonBuilder? selectedItemBuilder;
  Alignment? hintAlignment;
  Alignment? valueAlignment;
  double? buttonHeight, buttonWidth;
  EdgeInsetsGeometry? buttonPadding;
  BoxDecoration? buttonDecoration;
  int? buttonElevation;
  Widget? icon;
  double? iconSize;
  Color? iconEnabledColor;
  Color? iconDisabledColor;
  double? itemHeight;
  EdgeInsetsGeometry? itemPadding;
  double? dropdownHeight, dropdownWidth;
  EdgeInsetsGeometry? dropdownPadding;
  BoxDecoration? dropdownDecoration;
  int? dropdownElevation;
  Radius? scrollbarRadius;
  double? scrollbarThickness;
  bool? scrollbarAlwaysShow;
  Offset? offset;

  @override
  _SrDropdownState createState() => _SrDropdownState();
}

class _SrDropdownState extends State<SrDropdownButton>{

  bool isOpened = false;
  bool isSelected = false;
  double openRadius = 22;
  Color? selectedColor;
  String? selectedString;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        isDense: true,
        hint: Container(
          alignment: widget.hintAlignment,
          child: Row(
            children: [
              Icon(
                Icons.circle,
                size: widget.hasIcon && isSelected ? 11 : 0,
                color: selectedColor,
              ),
              Padding(padding: EdgeInsets.only(right: widget.hasIcon && isSelected ? 7 : 0)),
              Text.rich(
              TextSpan(
                  style: const TextStyle( fontWeight: FontWeight.w500, fontSize: 15, color: SrColors.black,),
                  children: [
                    TextSpan( text: selectedString ?? widget.hint),
                    TextSpan(text: widget.isRequired&&isSelected==false ? "(필수)" : "",  style: const TextStyle(color: SrColors.primary, fontSize: 15, fontWeight: FontWeight.w300))
                  ]
              ),
            ),]
          ),
        ),
        items: widget.dropdownItems.asMap().entries
            .map((entry) => DropdownMenuItem<String>(
          onTap: (){
            selectedColor = widget.dropdownIconColors?[entry.key];
            selectedString = entry.value;
          },
          value: entry.value,
          child: Column(children: <Widget>[
            const SizedBox(height: 10, width: 160),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 17)),
                Icon(
                  Icons.circle,
                  size: widget.hasIcon ? 11 : 0,
                  color: widget.dropdownIconColors?[entry.key],
                ),
                Padding(padding: EdgeInsets.only(right: widget.hasIcon ? 7 : 0)),
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
        onChanged: (value){
          setState(() {
            isSelected = true;
          });
        },
        selectedItemBuilder: widget.selectedItemBuilder,
        onMenuStateChange: (isOpened){
          setState(() {
            if (isOpened) {
              openRadius = 0;
            } else {
              openRadius = 22;
            }
            isOpened = !isOpened;
          });
        },
        icon: widget.icon ??
            SvgPicture.asset('assets/category_arrow.svg',
                width: 16, height: 16),
        iconOnClick: widget.icon ?? SvgPicture.asset('assets/arrow_up.svg', width: 16, height: 16),
        iconSize: widget.iconSize ?? 16,
        iconEnabledColor: widget.iconEnabledColor,
        iconDisabledColor: SrColors.gray2,
        buttonHeight: widget.buttonHeight ?? 44,
        buttonWidth: widget.buttonWidth ?? 160,
        buttonPadding:
        widget.buttonPadding ?? const EdgeInsets.only(left: 19, right: 14),
        buttonDecoration: BoxDecoration( borderRadius: BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22), bottomRight: Radius.circular(openRadius), bottomLeft: Radius.circular(openRadius)), color: Colors.white, border: Border.all(color: SrColors.gray1, width: 1) ),
        buttonElevation: widget.buttonElevation,
        itemHeight: 40,
        itemPadding: widget.itemPadding ?? EdgeInsets.zero,
        //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
        dropdownMaxHeight: 500,
        dropdownWidth: 160,
        dropdownPadding: widget.dropdownPadding ?? EdgeInsets.zero,
        dropdownDecoration: widget.dropdownDecoration ??
            BoxDecoration(
              border: Border.all(color: SrColors.gray1),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22), bottomRight:Radius.circular(22)),
            ),
        dropdownElevation: 0,
        scrollbarRadius: widget.scrollbarRadius ?? const Radius.circular(40),
        scrollbarThickness: widget.scrollbarThickness,
        scrollbarAlwaysShow: widget.scrollbarAlwaysShow,
        //Null or Offset(0, 0) will open just under the button. You can edit as you want.
        offset: Offset(0,1),
        dropdownOverButton: false, //Default is false to show menu below button
      ),
    );
  }
}


