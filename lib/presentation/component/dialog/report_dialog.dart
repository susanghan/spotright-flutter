import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

class ReportDialog extends StatelessWidget {
  const ReportDialog(
      {Key? key,
      this.title = "제목",
      this.options = const ["옵션1", "옵션2", "옵션3", "옵션4", "옵션5"],
      this.button = const TextButton(
        child: Text(""),
        onPressed: null,
      )})
      : super(key: key);

  final String title;
  final List<String> options;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    Set<int> selectedOptions = Set.of([1]);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: 390,
        padding: EdgeInsets.only(top: 24),
        child: Column(children: [
          Padding(padding: EdgeInsets.only(bottom: 12), child: Text(title)),
          _Options(),
          _InputField(),
          Spacer(),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: SrColors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _Options() {
    return Container(
      height: 104,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 5,
        children: [
          ...options
              .asMap()
              .entries
              .map((entry) => Row(children: [
                    SrCheckBox(
                      size: 24,
                      value: true,
                      onChanged: (bool checked) {},
                    ),
                    Padding(padding: EdgeInsets.only(right: 12)),
                    Text(entry.value)
                  ]))
              .toList()
        ],
      ),
    );
  }

  Widget _InputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
          children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: SrTextField(
            maxLines: 5,
            height: 84,
            borderRadius: 15,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
            child: Text("0/200", style: TextStyle(color: SrColors.gray2)))
      ]),
    );
  }
}
