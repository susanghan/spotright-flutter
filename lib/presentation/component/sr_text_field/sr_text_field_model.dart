class SrTextFieldModel {
  const SrTextFieldModel({this.hint = '', this.onChanged});

  final String hint;
  final Function(String)? onChanged;
}