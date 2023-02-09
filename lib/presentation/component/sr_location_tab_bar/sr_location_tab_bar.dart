import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';

class SrLocationTabBar extends StatefulWidget {
  const SrLocationTabBar({Key? key}) : super(key: key);

  @override
  State<SrLocationTabBar> createState() => _State();
}

class _State extends State<SrLocationTabBar> {


  bool _addressIsSelected = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 96,
      height: 32,
      decoration: BoxDecoration(color: SrColors.white, borderRadius: BorderRadius.circular(15),),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        _addressIsSelected = true;
                      });
                    },
                    child: AnimatedContainer(
                      width: 44,
                      height: 24,
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(color: _addressIsSelected ? SrColors.primary : SrColors.white, borderRadius: BorderRadius.circular(15),),
                      child: Center(child: Text("주소", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: _addressIsSelected ? SrColors.white : SrColors.primary),)),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _addressIsSelected = false;
                      });
                    },
                    child: AnimatedContainer(
                      width: 44,
                      height: 24,
                      decoration: BoxDecoration(color: !_addressIsSelected ? SrColors.primary : SrColors.white, borderRadius: BorderRadius.circular(15),),
                      duration: const Duration(milliseconds: 200),
                      child: Center(child: Text("장소", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: !_addressIsSelected ? SrColors.white : SrColors.primary),)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
