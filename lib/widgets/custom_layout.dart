import 'package:bloomscape_backend/model/product_model.dart';
import 'package:flutter/material.dart';

import '../config/responsive.dart';
import '../screens/menu/menu_screen.dart';
import 'product_card.dart';

class CustomLayout extends StatelessWidget {
  const CustomLayout({Key? key,required this.title,required this.widgets}) : super(key: key);
  final String title;
  final List<Widget>widgets;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme
                      .of(context)
                      .textTheme
                      .headline3,),
                  SizedBox(height: 20,),
                  ...widgets,
                  SizedBox(height: 20,),

                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 75),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    child: Center(child: Text("Some ads here"),),
                  ),
                ],
              ),
            ),
          ),
        ),

        Responsive.isWideDesktop(context) || Responsive.isDesktop(context) ?
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20, right: 20, bottom: 20),
            color: Theme
                .of(context)
                .backgroundColor,
            child: const Center(child: const Text("Some Adds here...")),),
        ) : SizedBox(),
      ],
      // ),
    );
  }

}