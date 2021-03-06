import 'package:auto_size_text/auto_size_text.dart';
import 'package:avalia_app/res/colors.dart';
import 'package:flutter/material.dart';

import '../../res/custom_icon_button.dart';

class LayoutPage {
  static void _backPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  // static void _backToBegin(BuildContext context) {
  //   Navigator.of(context)
  //       .popUntil(ModalRoute.withName(PerformEvaluationView.routeName));
  // }

  static Widget render({
    bool hasHeader = false,
    bool hasHeaderButtons = false,
    bool hasHeaderLogo = false,
    String headerTitle,
    String mainText,
    String message,
    Color color,
    BuildContext context,
    int numberPagesToHome,
    Widget content,
  }) {
    final deviceSize = MediaQuery.of(context).size;

    final _header = Container(
      width: deviceSize.width,
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: hasHeaderButtons ? Alignment.topLeft : Alignment.topCenter,
        children: [
          if (hasHeaderButtons)
            IconButton(
              iconSize: Theme.of(context).iconTheme.size,
              icon: Icon(
                CustomIconButton.button_back_without_desc,
                color: whiteColor,
              ),
              onPressed: () => _backPage(context),
            ),
          if (headerTitle != null)
            Container(
              padding: const EdgeInsets.only(top: 14.0),
              alignment: Alignment.center,
              height: deviceSize.height * 0.06,
              child: Text(
                headerTitle,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          if (hasHeaderLogo)
            Container(
              height: deviceSize.height * 0.25,
              padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
              child: Center(
                  child: Image.asset(
                'lib/res/images/avalia_logo.png',
              )
                  // Text(
                  //   headerTitle != null ? headerTitle : '',
                  //   style: Theme.of(context).textTheme.headline3,
                  // ),
                  ),
            ),
        ],
      ),
      // if (hasHeaderButtons)
      //   Padding(
      //     padding: const EdgeInsets.only(right: 48.0),
      //     child: IconButton(
      //       iconSize: Theme.of(context).iconTheme.size,
      //       icon: Icon(CustomIconButton.button_home),
      //       onPressed: () => _backToBegin(context),
      //     ),
      //   ),
    );

    final _mainText = Padding(
      padding: const EdgeInsets.only(top: 16),
      child: AutoSizeText(
        mainText != null ? mainText : '',
        wrapWords: false,
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
    );

    final _message = Text(
      message != null ? message : '',
      style: Theme.of(context).textTheme.headline5,
      textAlign: TextAlign.center,
    );

    Widget _buildSizedBox(double value) {
      return SizedBox(
        height: value,
      );
    }

    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: deviceSize.height * 0.95,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasHeader) _header,
                    if (mainText != null) _mainText,
                    if (mainText != null) _buildSizedBox(8),
                    if (message != null) _message,
                    if (message != null) _buildSizedBox(8),
                  ],
                ),
                if (content != null)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: deviceSize.height * 0.45,
                      maxHeight: deviceSize.height * 1.25,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        content,
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
