import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

/**
 * icon: 모달 상단에 표시된 아이콘
 * title: 제목
 * description: 설명
 * actions: 버튼 리스트
 */
class SrDialog extends StatelessWidget {
  const SrDialog(
      {Key? key,
      this.icon,
      this.title = "",
      this.description = "",
      this.actions})
      : super(key: key);

  final Widget? icon;
  final String title;
  final String description;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: 290,
        padding: EdgeInsets.only(top: 32),
        child: Column(children: [
          Container(
              alignment: Alignment.center,
              width: 64,
              height: 64,
              margin: EdgeInsets.only(bottom: 12),
              child: icon ?? Container()),
          Padding(padding: EdgeInsets.only(bottom: 12), child: Text(title)),
          Text(description),
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
              children: [..._Actions()],
            ),
          )
        ]),
      ),
    );
  }

  List<Widget> _Actions() {
    List<Widget> res = [];

    actions?.forEach((widget) {
      res.add(widget);
      if (widget != actions?.last) {
        res.add(Container(
          width: 1,
          height: 60,
          color: SrColors.white,
        ));
      }
    });

    return res;
  }
}
