class SrCTAButtonModel {
  const SrCTAButtonModel({this.text = '', this.isEnabled = true, required this.action});

  final String text;
  final bool isEnabled;
  final Function() action;
}