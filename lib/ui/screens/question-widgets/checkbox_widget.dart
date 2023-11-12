import 'package:eshkolot_offline/ui/custom_widgets/html_data_widget.dart';
import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {

  const CheckBoxWidget({super.key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged, required this.quizId,
  });

  final String label;
  final int quizId;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,

              onChanged: (newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(child: HtmlDataWidget(label, quizId: quizId)),
          ],
        ),
      ),
    );
  }
}