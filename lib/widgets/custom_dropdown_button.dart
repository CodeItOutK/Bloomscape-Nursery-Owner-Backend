import 'package:flutter/material.dart';

import '../model/category_model.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String>items;
  final Function(String?)? onChanged;
  const CustomDropdownButton({
    required this.items,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 75,
          child: Text("Category",style: Theme.of(context).textTheme.headline6,),),
        const SizedBox(width: 20,),
        Expanded(
          child: SizedBox(height: 45,
            child: DropdownButtonFormField(
              iconSize: 20,
              onChanged: onChanged,
              items:items
              .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              )
              ).toList(),
            ),),
        )
      ],
    );
  }
}