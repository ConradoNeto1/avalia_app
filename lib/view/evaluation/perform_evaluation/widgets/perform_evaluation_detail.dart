import 'package:flutter/material.dart';
//import '../../../../res/custom_icon.dart';
import '../../../layout/layout_buttons.dart';
import '../../../layout/layout_text_fields.dart';

import '../../../../res/colors.dart';

class PerformEvaluationDetail extends StatefulWidget {
  final Function isLoading;
  final Function searchForEvaluationCode;
  PerformEvaluationDetail(this.isLoading, this.searchForEvaluationCode);
  @override
  _PerformEvaluationDetailState createState() =>
      _PerformEvaluationDetailState();
}

class _PerformEvaluationDetailState extends State<PerformEvaluationDetail> {
  String _codigoAvaliacao;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    String _validateCodigo(String value) {
      if (value.trim().isEmpty) {
        return 'Por favor, informe o código.';
      } else {
        if (value.length < 4) {
          return 'O código possui mais de 4 caracteres. Por favor, verifique!';
        }
      }
      return null;
    }

    void _trySubmit() {
      final _isValid = _formKey.currentState.validate();
      FocusScope.of(context).unfocus();

      if (_isValid) {
        _formKey.currentState.save();
        widget.searchForEvaluationCode(_codigoAvaliacao);
      }
    }

    final _textField = Container(
      height: deviceSize.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Por favor,\n informe um código',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          LayoutTextFields.customTextFields(
            decoration: InputDecoration(
              hintText: 'Código',
              hintStyle: TextStyle(
                color: whitSoftColor,
              ),
            ),
            key: ValueKey('codigo'),
            onSaved: (codigo) {
              _codigoAvaliacao = codigo.trim();
            },
            onFieldSubmitted: (_) => _trySubmit(),
            validator: (codigo) => _validateCodigo(codigo),
          ),
        ],
      ),
    );

    final _button = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LayoutButtons.customRaisedButtons(
            textRaisedButtonOne: 'Buscar',
            //iconRaisedButtonOne: CustomIcon.icon_search_evaluation,
            color: yellowDeepColor,
            context: context,
            onPressedButtonOne: _trySubmit,
          ),
        ],
      ),
    );

    final _form = Form(
      key: _formKey,
      child: _textField,
    );

    final _progressIndicator = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    final _content = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: deviceSize.height * 0.83,
        maxHeight: deviceSize.height * 0.86,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _form,
          if (widget.isLoading()) _progressIndicator,
          _button,
        ],
      ),
    );

    return _content;
  }
}
