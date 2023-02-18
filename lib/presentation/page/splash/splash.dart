import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/colors.dart';


// Timer(Duration(milliseconds: 1500), () {
//   Navigator.push(context, MaterialPageRoute(
//       builder: (context) => const Login()
//   )
//   );
// });

//Todo: 그냥 가운데로만 하면 됨. 조정 안 필요함.
class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final String imageLogoName = 'assets/splash122.svg';

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:1.0),
        child: Scaffold(
          backgroundColor: SrColors.primary,
          body: Container(
            //height : MediaQuery.of(context).size.height,
            //color: kPrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.384375),
                Container(
                  child: SvgPicture.asset(
                    imageLogoName,
                    width: screenWidth * 0.616666,
                    height: screenHeight * 0.0859375,
                  ),
                ),
                Expanded(child: SizedBox()),
                SizedBox( height: MediaQuery.of(context).size.height*0.0625,),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
