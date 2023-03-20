import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

class ReportDialog extends StatefulWidget {

  ReportDialog({Key? key,
    this.title = "제목",
    this.options = const {"1": "옵션1", "2": "옵션2"},
    required this.onFinish,
  }): super(key: key);

  final String title;
  final Map<String, String> options;
  Function(String type, String reason)? onFinish;

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String selectedKey = "";
  String reason = "";

  @override
  void initState() {
    super.initState();
    selectedKey = widget.options.keys.first;
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: 390,
        padding: EdgeInsets.only(top: 24),
        child: Column(children: [
          Padding(padding: EdgeInsets.only(bottom: 36), child: Text(widget.title, style: SrTypography.body1semi)),
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
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    widget.onFinish?.call(selectedKey, reason);
                  },
                  child: Text("신고하기", style: SrTypography.body2semi.copy(color: SrColors.white),)
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _Options() {
    return Container(
      height: 104,
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 5,
        children: [
          ...widget.options
              .entries
              .map((entry) => Row(children: [
            SrCheckBox(
              size: 24,
              value: entry.key == selectedKey,
              onChanged: (bool checked) {
                if(checked) {
                  setState(() {
                    selectedKey = entry.key;
                  });
                }
              },
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
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: SrTextField(
                maxLines: 5,
                maxLength: 200,
                height: 84,
                borderRadius: 15,
                onChanged: (text) {
                  reason = text;
                },
              ),
            ),
          ]),
    );
  }
}
