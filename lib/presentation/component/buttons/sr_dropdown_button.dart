import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/page/add_spot/add_spot.dart';

class SrDropdownButton extends StatefulWidget {
  SrDropdownButton(
      {Key? key,
      required this.hint,
      required this.dropdownItems,
      required this.onChanged,
      required this.hasIcon,
      this.dropdownIconColors,
      required this.isRequired,
      this.buttonWidth,
      required this.isSelected,
      this.selectedString})
      : super(key: key);

  String hint; //카테고리 제몰
  final List<String> dropdownItems; //버튼 누르면 나오는 아이템들 List
  final ValueChanged<String?>? onChanged; //아이템 선택했을 때 실행되는 함수
  final bool hasIcon; //드롭다운 아이템이 앞에 아이콘을 갖고 있는지
  bool isRequired; //필수 항목인지(글자 표시됨)
  List<Color>? dropdownIconColors; //드롭다운 아이템이 갖고 있는 아이콘의 색들

  bool isSelected = false;
  String? selectedString;

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

class _SrDropdownState extends State<SrDropdownButton> {


  bool isActive = false;
  Color activeButtonColor = SrColors.gray2;


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        isDense: true,
        hint: Container(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  color: SrColors.black,
                ),
                children: [
                  TextSpan(text: widget.hint),
                  TextSpan(
                      text: widget.isRequired ? " *" : "",
                      style: const TextStyle(
                          color: SrColors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w300))
                ]),
          ),
        ),
        items: widget.dropdownItems
            .asMap()
            .entries
            .map((entry) => DropdownMenuItem<String>(
                  value: entry.value,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 16)),
                          Icon(
                            Icons.circle,
                            size: widget.hasIcon ? 15 : 0,
                            color: widget.dropdownIconColors?[entry.key],
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: widget.hasIcon ? 10 : 0)),
                          Text(
                            entry.value,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: SrColors.gray1),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ))
            .toList(),

        onChanged: widget.onChanged,
        value: widget.selectedString,
        selectedItemBuilder: widget.selectedItemBuilder,
        onMenuStateChange: (isOpened) {
          setState(() {
            if (isOpened) {
              activeButtonColor = SrColors.gray1;
            } else {
              activeButtonColor = SrColors.gray2;
            }
            isOpened = !isOpened;
          });
        },
        icon: widget.icon ??
            SvgPicture.asset(
              'assets/category_arrow_down.svg',
              width: 16,
              height: 16,
              color: activeButtonColor,
            ),
        iconOnClick: widget.icon ??
            SvgPicture.asset(
              'assets/category_arrow_up.svg',
              width: 17,
              height: 17,
              color: activeButtonColor,
            ),
        iconSize: widget.iconSize ?? 16,
        iconEnabledColor: widget.iconEnabledColor,
        iconDisabledColor: SrColors.gray2,
        buttonHeight: widget.buttonHeight ?? 46,
        buttonWidth: widget.buttonWidth,
        buttonPadding: widget.isSelected
            ? const EdgeInsets.only(left: 0, right: 16)
            : const EdgeInsets.symmetric(horizontal: 16),
        //widget.buttonPadding ,
        buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            color: Colors.white,
            border: Border.all(color: activeButtonColor, width: 1)),
        buttonElevation: widget.buttonElevation,
        itemHeight: 45,
        itemPadding: widget.itemPadding ?? EdgeInsets.zero,
        //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
        dropdownMaxHeight: 500,
        dropdownWidth: widget.buttonWidth,
        dropdownPadding: widget.dropdownPadding ?? EdgeInsets.zero,
        dropdownDecoration: widget.dropdownDecoration ??
            BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: SrColors.gray3.withOpacity(0.7),
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 7),
                )
              ],
              border: Border.all(color: SrColors.gray3),
              borderRadius: const BorderRadius.all(Radius.circular(22)),
            ),
        dropdownElevation: 0,
        scrollbarRadius: widget.scrollbarRadius ?? const Radius.circular(40),
        scrollbarThickness: widget.scrollbarThickness,
        scrollbarAlwaysShow: widget.scrollbarAlwaysShow,
        offset: Offset(0, -4),
      ),
    );
  }
}
