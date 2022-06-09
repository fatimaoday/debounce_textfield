import 'package:flutter/material.dart';
import 'dart:async';

class DebounceTextfield extends StatefulWidget {
  Function action;
  VoidCallback? onTextfieldEmpty;
  Duration duration;
  double height;
  Widget inputIcon;
  TextStyle textFieldStyle;
  BoxDecoration textFieldDecoration;
  String hintText;
  TextStyle hintStyle;
  TextDirection direction;
  Widget clearButtonIcon;
  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;

  DebounceTextfield({
    required this.action,
    this.onTextfieldEmpty,
    this.duration = const Duration(milliseconds: 500),
    this.height = 40,
    this.inputIcon = const SizedBox.shrink(),
    this.textFieldStyle = const TextStyle(fontSize: 13),
    this.textFieldDecoration = const BoxDecoration(color: Color(0xffE8E8E8)),
    this.hintText = '',
    this.hintStyle = const TextStyle(fontSize: 13, color: Color(0xffaeaeae)),
    this.clearButtonIcon =
        const Icon(Icons.clear_rounded, color: Color(0xffaeaeae), size: 20),
    this.direction = TextDirection.ltr,
    this.margin = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    Key? key,
  }) : super(key: key);

  @override
  State<DebounceTextfield> createState() => _DebounceTextfieldState();
}

class _DebounceTextfieldState extends State<DebounceTextfield> {
  late Function _action;
  late Duration _duration;
  late StreamController<bool> _btnClearController;
  late TextEditingController _inputController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _action = widget.action;
    _duration = widget.duration;
    _btnClearController = StreamController<bool>();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _btnClearController.close();
    _inputController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  runDebouncer(String text) {
    _timer?.cancel();
    if (text.isNotEmpty) {
      _btnClearController.add(true);
      _timer = Timer(_duration, () => _action(text));
    } else {
      _btnClearController.add(false);
      if (widget.onTextfieldEmpty != null) {
        widget.onTextfieldEmpty!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.direction,
      child: Container(
        height: widget.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.inputIcon,
            const SizedBox(width: 5),
            Expanded(
              child: TextFormField(
                controller: _inputController,
                onChanged: (value) => runDebouncer(value),
                decoration: InputDecoration.collapsed(
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle,
                ),
                style: widget.textFieldStyle,
              ),
            ),
            StreamBuilder<bool>(
                stream: _btnClearController.stream,
                builder: (context, snapshot) {
                  return snapshot.data == true
                      ? GestureDetector(
                          onTap: () {
                            _inputController.clear();
                            _btnClearController.add(false);
                            if (widget.onTextfieldEmpty != null) {
                              widget.onTextfieldEmpty!();
                            }
                          },
                          child: widget.clearButtonIcon)
                      : const SizedBox.shrink();
                }),
          ],
        ),
        decoration: widget.textFieldDecoration,
        padding: widget.padding,
        margin: widget.margin,
      ),
    );
  }
}
