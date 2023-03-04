import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

import '../../../data/resources/geo.dart';
import 'sr_custom_drop_down.dart';

class SrRecommendTextField extends StatefulWidget {
  SrRecommendTextField(
      {Key? key,
      required this.focusOut,
      required this.inputController,
      required this.onDropdownPressed,
      required this.searchList,
      required this.onChanged})
      : super(key: key);

  late TextEditingController inputController;
  List<String> searchList;
  Function() onChanged;
  Function() onDropdownPressed;
  Function() focusOut;

  @override
  State<SrRecommendTextField> createState() => _SrRecommendTextFieldState();
}

class _SrRecommendTextFieldState extends State<SrRecommendTextField> {
  late FocusNode _inputFocusNode;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  List<String>? resultList;

  bool _isDropdownSelected = false;

  void _removeInputOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    _inputFocusNode = FocusNode()
      ..addListener(() {
        if (!_inputFocusNode.hasFocus) {
          _removeInputOverlay();
        }
      });
  }

  @override
  void dispose() {
    widget.inputController.dispose();
    _overlayEntry?.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (foucus) {
        if (!foucus &&
            widget.inputController.text.isNotEmpty &&
            !_isDropdownSelected) {
          widget.inputController.text = resultList![0];
          widget.focusOut();
        }
      },
      child: GestureDetector(
        onTap: () {
          final _currentFocus = FocusScope.of(context);
          if (!_currentFocus.hasPrimaryFocus) {
            _currentFocus.unfocus();
          }
        },
        child: _inputTextField(),
      ),
    );
  }

  void searchKeyword(String input) {
    resultList = widget.searchList
        .where((searchList) => searchList.contains(input))
        .toList();
  }

  Widget _inputTextField() {
    void _showInputOverlay() {
      widget.onChanged();
      _isDropdownSelected = false;

      if (_inputFocusNode.hasFocus) {
        if (widget.inputController.text.isNotEmpty) {
          final _input = widget.inputController.text;

          searchKeyword(_input);

          _removeInputOverlay();

          _overlayEntry = _inputListOverlayEntry();
          Overlay.of(context)?.insert(_overlayEntry!);
        } else {
          _removeInputOverlay();
        }
      }
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: SrTextField(
        height: 45,
        controller: widget.inputController,
        focusNode: _inputFocusNode,
        textInputAction: TextInputAction.next,
        onChanged: (_) => _showInputOverlay(),
      ),
    );
  }

  OverlayEntry _inputListOverlayEntry() {
    return srCustomDropdown.inputRecommendation(
      inputList: resultList?.length == 0
          ? resultList = widget.searchList.take(5).toList()
          : resultList?.take(5),
      inputListChanged: () {
        resultList = resultList;
      },
      margin: EdgeInsets.symmetric(horizontal: 0),
      layerLink: _layerLink,
      controller: widget.inputController,
      onPressed: () {
        widget.onDropdownPressed();
        setState(() {
          _isDropdownSelected = true;
          _inputFocusNode.unfocus();
          _removeInputOverlay();
        });
      },
    );
  }
}
