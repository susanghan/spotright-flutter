import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

import '../../../data/resources/geo.dart';
import 'sr_custom_drop_down.dart';

class SrRecommendTextField extends StatefulWidget {
  const SrRecommendTextField({Key? key}) : super(key: key);

  @override
  State<SrRecommendTextField> createState() => _SrRecommendTextFieldState();
}

class _SrRecommendTextFieldState extends State<SrRecommendTextField> {

  late TextEditingController _inputController;
  late FocusNode _inputFocusNode;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<String>? resultList;

  void _removeInputOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
    _inputFocusNode = FocusNode()
      ..addListener(() {
        if (!_inputFocusNode.hasFocus) {
          _removeInputOverlay();
        }
      });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _overlayEntry?.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final _currentFocus = FocusScope.of(context);
        if (!_currentFocus.hasPrimaryFocus) {
          _currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[ _inputTextField(),]
        ),
      ),
    );
  }

  List<String> krProvinceGeo = Geo.krGeo.keys.toList();

  void searchKeyword(String input) {
    resultList = krProvinceGeo.where((krProvinceGeo) => krProvinceGeo.contains(input)).toList();

  }

  Widget _inputTextField() {
    void _showInputOverlay() {
      if (_inputFocusNode.hasFocus) {
        if (_inputController.text.isNotEmpty) {
          final _input = _inputController.text;

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SrTextField(
          height: 45,
          controller: _inputController,
          focusNode: _inputFocusNode,
          textInputAction: TextInputAction.next,
          onChanged: (_) => _showInputOverlay(),
        ),
      ),
    );
  }

  OverlayEntry _inputListOverlayEntry() {
    return srCustomDropdown.inputRecommendation(
      inputList: resultList?.take(5),
      margin: EdgeInsets.symmetric(horizontal: 16),
      layerLink: _layerLink,
      controller: _inputController,
      onPressed: () {
        setState(() {
          _inputFocusNode.unfocus();
          _removeInputOverlay();
        });
      },
    );
  }
}
