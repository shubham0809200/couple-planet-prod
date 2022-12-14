import 'package:flutter/material.dart';

class DropDownAnswer extends StatelessWidget {
  final String? title;
  final void Function(String?) onChanged;
  final List<String> values;
  final String value;
  final bool? isDisable;
  const DropDownAnswer({
    Key? key,
    this.title,
    required this.onChanged,
    required this.values,
    required this.value,
    this.isDisable,
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
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ),
              ],
            ),
          ),
        Container(
          height: 60.0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: values.map((String value) {
                return DropdownMenuItem<String>(
                  enabled: isDisable ?? true,
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        fontSize: 14,
                        color: isDisable != null
                            ? isDisable == false
                                ? Colors.grey
                                : Colors.black
                            : Theme.of(context).colorScheme.primary),
                  ),
                );
              }).toList(),
              value: value,
              isExpanded: true,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
