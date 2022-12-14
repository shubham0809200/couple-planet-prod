import 'package:flutter/material.dart';

class SingleAnswer extends StatelessWidget {
  final String? title;
  final String? prefixText;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? label;
  final String? hint;
  final bool? enable;
  final Function()? onTap;
  final int? maxLines;
  const SingleAnswer({
    Key? key,
    this.title,
    this.prefixText,
    this.textInputType,
    required this.controller,
    required this.onChanged,
    this.label,
    this.hint,
    this.enable,
    this.onTap,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(title!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                ),
              ],
            ),
          ),
        TextField(
          minLines: maxLines ?? 1,
          enabled: enable ?? true,
          controller: controller,
          style: TextStyle(
              fontSize: 14,
              color: enable != null
                  ? enable == false
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey
                  : Theme.of(context).colorScheme.primary),
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label ?? 'Answer',
              hintText: hint ?? 'Enter your Answer',
              prefixText: prefixText),
          keyboardType: textInputType ?? TextInputType.multiline,
          maxLines: null,
          onChanged: onChanged,
          onTap: onTap,
        ),
      ],
    );
  }
}
