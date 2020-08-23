import 'package:avalia_app/model/evaluation/evaluation_model.dart';
import 'package:flutter/material.dart';

import '../../../view/layout/layout_alert.dart';
import '../../layout/layout_page.dart';
import '../../../view_model/perform_evaluation_view_model.dart';
import 'widgets/perform_evaluation_detail.dart';
import '../../../utils/loading_status.dart';
import '../../../res/colors.dart';

class PerformEvaluationView extends StatefulWidget {
  static const routeName = '/realizar_avaliacao';
  final String title;

  PerformEvaluationView(this.title);

  @override
  _PerformEvaluationViewState createState() => _PerformEvaluationViewState();
}

class _PerformEvaluationViewState extends State<PerformEvaluationView> {
  final _viewModel = PerformEvaluationViewModel();
  bool _isLoading = false;

  void setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  bool getIsLoading() {
    return _isLoading;
  }

  Widget _buildText(String textHeader, String textField) {
    return Row(
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: yellowDeepColor,
                fontWeight: FontWeight.bold,
              ),
          child: Text(
            textHeader,
            textAlign: TextAlign.left,
          ),
        ),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: yellowDeepColor,
              ),
          child: Text(
            textField,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Future<void> _buildEvaluation(EvaluationModel evaluation) {
    final message = FittedBox(
      alignment: Alignment.topLeft,
      fit: BoxFit.contain,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText(
            'Etapa Ensino: ',
            evaluation.stageEducation,
          ),
          _buildText(
            'Disciplina: ',
            evaluation.discipline,
          ),
          _buildText(
            'Ano Escolar: ',
            '${evaluation.schoolYear.toString()}º',
          ),
          _buildText(
            'Turma: ',
            evaluation.team,
          ),
          _buildText(
            'Quantidade de Questões: ',
            evaluation.totalQuestions.toString(),
          ),
          _buildText(
            'Tempo Mínimo: ',
            evaluation.totalTime,
          ),
        ],
      ),
    );

    final buttons = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
            child: Text('Cancelar'),
          ),
          color: yellowDeepColor,
        ),
        SizedBox(
          width: 24.0,
        ),
        RaisedButton(
          onPressed: () {},
          color: yellowDeepColor,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
            child: Text('Iniciar'),
          ),
        )
      ],
    );
    final alert = LayoutAlert.customAlert(
      title: 'Realizar Avaliação',
      color: yellowDeepColor,
      context: context,
      message: message,
      actionButtons: buttons,
    );
    return alert;
  }

  void _searchForEvaluationCode(String codigo) async {
    setLoading(true);
    final result = await _viewModel.getEvaluation(codigo);
    if (result != null) {
      await _buildEvaluation(result);
    }
    switch (_viewModel.loadingStatus) {
      case LoadingStatus.completed:
        setLoading(false);

        break;
      case LoadingStatus.error:
        if (_viewModel.exception != null) {
          setLoading(false);
        }
        break;
      default:
        setLoading(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPage.render(
      hasHeader: true,
      hasHeaderButtons: true,
      headerTitle: 'avalia',
      context: context,
      mainText: widget.title,
      message: 'Por favor,\n informe o código',
      color: yellowDeepColor,
      content: PerformEvaluationDetail(getIsLoading, _searchForEvaluationCode),
    );
  }
}