import 'package:flutter/material.dart';

class LayoutButtons {
  static Widget customRaisedButtons({
    String textRaisedButtonOne,
    IconData iconRaisedButtonOne,
    Function() onPressedButtonOne,
    String textRaisedButtonTwo,
    IconData iconRaisedButtonTwo,
    Function onPressedButtonTwo,
    Color color,
    BuildContext context,
  }) {
    final deviceSize = MediaQuery.of(context).size;

    Widget _buildButton(
      String textButton,
      IconData iconButton,
      Function onPressedButton,
    ) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        height: 60,
        width: deviceSize.width,
        child: Stack(
          children: [
            Container(
              width: deviceSize.width * 0.9,
              height: 60,
              child: RaisedButton(
                color: Theme.of(context).backgroundColor,
                onPressed: onPressedButton,
                child: Text(
                  textButton != null ? textButton : '',
                  style: TextStyle(
                    color: color != null ? color : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (iconButton != null)
              Positioned(
                top: 16,
                right: 32,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    iconTheme: Theme.of(context).iconTheme.copyWith(
                          color: color != null ? color : Colors.white,
                        ),
                  ),
                  child: Icon(
                    iconButton,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (textRaisedButtonTwo != null)
          _buildButton(
              textRaisedButtonTwo, iconRaisedButtonTwo, onPressedButtonTwo),
        if (textRaisedButtonOne != null)
          _buildButton(
              textRaisedButtonOne, iconRaisedButtonOne, onPressedButtonOne),
      ],
    );
  }

  static Widget customFlatButtons({
    String text,
    Function onPressed,
    BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
