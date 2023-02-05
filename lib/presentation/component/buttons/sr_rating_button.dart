import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrRatingButton extends StatefulWidget {
  SrRatingButton({Key? key, required this.ratingMode, this.initialRating = 0})
      : super(key: key);

  RatingMode ratingMode;
  double initialRating;

  @override
  _SrRatingButtonState createState() => _SrRatingButtonState();
}

class _SrRatingButtonState extends State<SrRatingButton> {
  final List<String> _ratingText = [
    "별점을 입력해 주세요.",
    "방문해 볼 만한 장소군요!",
    "여러 번 방문해 볼 만한 장소군요!",
    "어디에 있든 다시 방문하고 싶은 장소군요!"
  ];
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RatingBar.builder(
        ignoreGestures: widget.ratingMode == RatingMode.readOnly,
        initialRating: widget.initialRating,
        minRating: 0,
        allowHalfRating: false,
        unratedColor: SrColors.gray3,
        itemCount: 3,
        itemSize: widget.ratingMode == RatingMode.interactive ? 45 : 12,
        glowColor: SrColors.white,
        itemPadding: widget.ratingMode == RatingMode.interactive
            ? const EdgeInsets.only(right: 16)
            : const EdgeInsets.only(right: 2),
        itemBuilder: (context, _) => widget.ratingMode == RatingMode.interactive
            ? SvgPicture.asset(
                'assets/star.svg',
                width: 45,
                height: 45,
                color: SrColors.primary,
              )
            : SvgPicture.asset(
                'assets/star.svg',
                width: 12,
                height: 12,
                color: SrColors.primary,
              ),
        onRatingUpdate: (rating) {
          setState(() {
             _rating = rating;
          });
        },
        updateOnDrag: true,
      ),
      SizedBox(
        height: widget.ratingMode == RatingMode.interactive ? 12 : 0,
      ),
      Text(
        _ratingText[_rating.round()],
        style: TextStyle(
            fontSize : widget.ratingMode == RatingMode.interactive ? 15 : 0, fontWeight: FontWeight.w500, color: SrColors.black),
      )
    ]);
  }
}

enum RatingMode { interactive, readOnly }
