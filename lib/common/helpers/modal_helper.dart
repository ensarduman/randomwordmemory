import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instantmessage/style/style_colors.dart';
import 'package:instantmessage/widgets/modal/modal_bottom.dart';

enum ButtonOrder { vertical, horizontal }

class ModalHelper {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showBottomModal(
    BuildContext context, {
    Widget content,
    String title,
    double horizontalPadding = 20,
    Widget text,
    Function onClose,
    bool enableTextArea = false,
    String textAreaText,
    String textAreaHintText,
    Function(String value) onTextAreaChanged,
    bool enableSaveAndCancelButtons = false,
    int minLines = 2,
    int maxLines = 3,
    Function onCancel,
    Function onSave,
    double height,
  }) {
    showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ModalBottom(
                    height: height,
                    title: title,
                    text: text,
                    content: content,
                    horizontalPadding: horizontalPadding,
                    enableTextArea: enableTextArea,
                    textAreaText: textAreaText,
                    textAreaHintText: textAreaHintText,
                    onTextAreaChanged: onTextAreaChanged,
                    enableSaveAndCancelButtons: enableSaveAndCancelButtons,
                    minLines: minLines,
                    maxLines: maxLines,
                    onCancel: onCancel,
                    onSave: onSave,
                  ),
                ),
              );
            },
            context: context)
        .then((value) {
      if (onClose != null) {
        onClose();
      }
    });
  }

  static void closeModals(BuildContext context) {
    Navigator.pop(context);
  }

  static void showModalDialog(BuildContext context,
      {String title,
      Color color = StyleColors.bottomModalTitle,
      String contentText,
      ButtonOrder buttonOrder = ButtonOrder.vertical,
      bool enableFirstButton = false,
      bool enableSecondButton = false,
      Function onFirstButtonClick,
      Function onSecondButtonClick,
      String firstButtonText,
      String secondButtonText,
      Function onClose}) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  title: title != null
                      ? Text(
                          title,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                            fontSize: 20.0,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                  content: Column(
                    children: [
                      (contentText != null
                          ? Text(
                              contentText,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Quicksand",
                                fontSize: 16.0,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : Container()),
                      SizedBox(
                        height: 24,
                      ),
                      Column(
                        children: [
                          enableFirstButton
                              ? Container(
                                  height: 40,
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(4.0),
                                  ),
                                  child: RaisedButton(
                                    child: Center(
                                      child: firstButtonText != null
                                          ? Text(
                                              firstButtonText,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Quicksand",
                                              ),
                                            )
                                          : Container(),
                                    ),
                                    color: color,
                                    onPressed: () {
                                      if (onFirstButtonClick != null) {
                                        onFirstButtonClick();
                                      }
                                    },
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 8,
                          ),
                          enableSecondButton
                              ? Container(
                                  height: 40,
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(4.0),
                                    border: Border.all(color: Colors.blue[500], width: 1.0),
                                  ),
                                  child: RaisedButton(
                                    child: Center(
                                      child: secondButtonText != null
                                          ? Text(
                                              secondButtonText,
                                              style: TextStyle(
                                                color: Colors.blue[500],
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Quicksand",
                                              ),
                                            )
                                          : Container(),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      // Navigator.pop(context, showBottomModal);
                                      if (onSecondButtonClick != null) {
                                        onSecondButtonClick();
                                      }
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {},
    ).then((value) {
      if (onClose != null) {
        onClose();
      }
    });
  }
}
