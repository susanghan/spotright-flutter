import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/dialog/sr_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionRepository {
  Future<void> checkAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if(await VersionRepository().needToUpdate() == 1) {
      Get.dialog(SrDialog(icon: SvgPicture.asset('assets/bulb_new.svg'), title: "최신버전으로 업데이트 해주세요",
        description: '업데이트로 더 편리해진 Spotright!',
        actions: [
        TextButton(onPressed: () => exit(0), child: Text("앱 종료", style: SrTypography.body2medium.copy(color: SrColors.white),)),
        TextButton(onPressed: () {
          if(Platform.isAndroid) {
            Uri url = Uri.parse('https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
            launchUrl(url);
          } else {
            Uri url = Uri.parse('http://apps.apple.com/kr/app/${packageInfo.appName}/id6446425594');
            launchUrl(url);
          }
        }, child: Text("업데이트", style: SrTypography.body2medium.copy(color: SrColors.white),))
      ],));//.then((_) => exit(0));
    }
  }

  /**
   * return values
   * -1 : what the fuck?
   * 0 : 업데이트할 필요 없음
   * 1 : 업데이트가 필요함
   */
  Future<int> needToUpdate() async {
    String versionName = await _getStoreVersion();
    if(versionName.isEmpty) return -1;
    List<int> storeVersionNumbers = versionName.split(".").map((number) => int.parse(number)).toList();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    List<int> versionNumbers = packageInfo.version.split(".").map((number) => int.parse(number)).toList();

    if(storeVersionNumbers[0] == versionNumbers[0] && storeVersionNumbers[1] == versionNumbers[1]) return 0;

    return 1;
  }

  Future<String> _getStoreVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return Platform.isAndroid ? _getAndroidStoreVersion(packageInfo) : _getIOSStoreVersion(packageInfo);
  }

  Future<String> _getAndroidStoreVersion(
      PackageInfo packageInfo) async {
    final id = packageInfo.packageName;
    final uri =
    Uri.https("play.google.com", "/store/apps/details", {"id": "$id"});
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      debugPrint('Can\'t find an app in the Play Store with the id: $id');
      return "";
    }
    final document = parse(response.body);
    final elements = document.getElementsByClassName('hAyfc');
    final versionElement = elements.firstWhere(
          (elm) => elm.querySelector('.BgcNfc')?.text == 'Current Version',
    );
    return versionElement.querySelector('.htlgb')?.text ?? '';
  }

  Future<String> _getIOSStoreVersion(PackageInfo packageInfo) async {
    final id = packageInfo.packageName;

    final parameters = {"bundleId": "$id"};

    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      debugPrint('Can\'t find an app in the App Store with the id: $id');
      return "";
    }

    final jsonObj = jsonDecode(response.body);

    debugPrint(response.body.toString());
    return jsonObj['results'][0]['version'];
  }
}