import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final String title;
  final String initialValue;
  final bool hasTitle;
  final Function(String)? onChanged;
  final Function(bool)? onFocusChanged;
  const CustomTextFormField({
    super.key,
    required this.maxLines,
    required this.title,
    required this.initialValue,
    required this.hasTitle,
    required this.onChanged,
    this.onFocusChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          hasTitle
            ?SizedBox(width: 75,child: Text(title,style: Theme.of(context).textTheme.headline6,))
            :const SizedBox(),
          Expanded(
            child: Focus(
              child: TextFormField(
                maxLines: maxLines,
                initialValue: initialValue,
                onChanged: onChanged,
                onEditingComplete: (){
                  print("Done");
                },
                decoration: InputDecoration(
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    )
                ),
              ),
              onFocusChange: onFocusChanged??(hasFocus){},
            ),
          ),
        ],
      ),
    );
  }
}