import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instantmessage/common/helpers/modal_helper.dart';
import 'package:instantmessage/common/localization/localization.dart';
import 'package:instantmessage/widgets/modal/modal_bottom_buttons.dart';
import 'package:instantmessage/widgets/modal/modal_bottom_indicator.dart';
import 'package:instantmessage/widgets/modal/modal_title.dart';

class ModalBottom extends StatefulWidget {
  final Widget content;

  final String title;
  final Widget text;
  final String textAreaText;
  final String textAreaHintText;

  final int minLines;
  final int maxLines;
  final double horizontalPadding;
  final double height;
  final bool enableTextArea;
  final bool enableSaveAndCancelButtons;

  final Function onCancel;
  final Function onSave;
  final Function(String value) onTextAreaChanged;

  ModalBottom({
    this.title,
    this.content,
    this.horizontalPadding,
    this.text,
    this.enableTextArea = false,
    this.textAreaText,
    this.textAreaHintText,
    this.onTextAreaChanged,
    this.enableSaveAndCancelButtons = false,
    this.minLines = 2,
    this.maxLines = 3,
    this.onCancel,
    this.onSave,
    this.height,
  });

  @override
  _ModalBottomState createState() => _ModalBottomState();
}

class _ModalBottomState extends State<ModalBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.only(topLeft: const Radius.circular(8.0), topRight: Radius.circular(8.0))),
      child: Column(children: [
        Padding(
          padding: new EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
          child: Column(
            children: [
              ModalBottomIndicator(),
              SizedBox(
                height: 12,
              ),
              widget.title == null
                  ? SizedBox()
                  : Column(
                      children: [
                        ApmModalTitle(widget.title),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
              widget.content ?? Container(),
              widget.text ?? Container(),
            ],
          ),
        ),
        widget.enableSaveAndCancelButtons
            ? ModalBottomButtons(
                isRightButtonDisabled: false,
                onLeftClick: () {
                  ModalHelper.closeModals(context);
                  widget.onCancel();
                },
                onRightClick: widget.onSave,
                leftButtonText: localize(context, 'Cancel'),
                rightButtonText: localize(context, 'Save'),
              )
            : Container()
      ]),
    );
  }
}
