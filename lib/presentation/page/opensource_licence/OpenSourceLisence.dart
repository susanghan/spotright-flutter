import 'package:flutter/material.dart';
import 'package:spotright/oss_licenses.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceLicence extends StatelessWidget {
  OpenSourceLicence({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: DefaultAppBar(
              title: "오픈소스 라이센스",
              hasBackButton: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: ossLicenses.map((licence) => _Item(licence)).toList(),
              ),
            )));
  }

  Widget _Item(Package licence) {
    return GestureDetector(
      onTap: () {
        Uri url = Uri.parse(licence.repository ?? "");
        launchUrl(url);
      },
      child: Container(
        color: Colors.white,
        child: Row(children: [
          Flexible(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  "${licence.name} ${licence.version}",
                  style: SrTypography.body1semi,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text(licence.description))
            ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.arrow_forward_ios, color: SrColors.gray1,))
        ]),
      ),
    );
  }
}
