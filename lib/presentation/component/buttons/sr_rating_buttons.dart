import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrRatingButton extends StatefulWidget {
  const SrRatingButton({Key? key}) : super(key: key);

  @override
  _SrRatingButtonState createState() => _SrRatingButtonState();
}

class _SrRatingButtonState extends State<SrRatingButton> {
  final List<String> _ratingText = ["별점을 입력해 주세요.", "방문해 볼 만한 장소군요!", "여러 번 방문해 볼 만한 장소군요!", "어디에 있든 다시 방문하고 싶은 장소군요!"];
  late double _rating;

  double _initialRating = 0;

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: _initialRating,
          minRating: 0,
          allowHalfRating: false,
          unratedColor: SrColors.gray3,
          itemCount: 3,
          itemSize: 45,
          glowColor: SrColors.white,
          itemPadding: const EdgeInsets.only(right: 15),
          itemBuilder: (context, _) => SvgPicture.asset('assets/star.svg', width: 45, height: 45, color: SrColors.primary,),
          onRatingUpdate: (rating){
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        ),
        Text(_ratingText[_rating.round()], style: const TextStyle(fontWeight: FontWeight.w500, color: SrColors.black),)
      ]
    );
  }
}
