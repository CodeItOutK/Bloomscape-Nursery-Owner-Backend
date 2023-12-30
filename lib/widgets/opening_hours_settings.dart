import 'package:bloomscape_backend/config/responsive.dart';
import 'package:flutter/material.dart';

import '../model/opening_hours_model.dart';

class OpeningHoursSettings extends StatelessWidget {
  final OpeningHours openingHours;
  final Function(bool?)? onCheckboxChanged;
  final Function(RangeValues)? onSliderChanged;
  const OpeningHoursSettings({
    super.key, required this.openingHours, this.onCheckboxChanged, this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    double heigt=Responsive.isMobile(context)?110:55;
    EdgeInsets padding = Responsive.isMobile(context)?EdgeInsets.all(10):EdgeInsets.all(20);
    return Container(
      height: heigt,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: padding,
      color: Theme.of(context).backgroundColor,
      child: Responsive.isMobile(context)?
      Column(
        children: [
          Row(
            children: [
              _buildCheckbox(context),
              const SizedBox(width: 10,),
              _buildText(context)
            ],
          ),
          const SizedBox(height: 10,),
          Expanded(child: _buildSlider(context)),

        ],
      )
      :
      Row(
        children: [
          _buildCheckbox(context),
          const SizedBox(width: 10,),
          Expanded(child: _buildSlider(context)),
          const SizedBox(width: 10,),

          _buildText(context)
        ],
      ),
    );
  }

  SizedBox _buildText(BuildContext context) {
    return SizedBox(width: 125,child: openingHours.isOpen?
        Text("Open from ${openingHours.openAt} to ${openingHours.closeAt}",style: Theme.of(context).textTheme.headline5,)
            :Text("Closed on ${openingHours.day}",style: Theme.of(context).textTheme.headline5,),
        );
  }

  Row _buildCheckbox(BuildContext context) {
    return Row(
          children: [
            Checkbox(
                value: openingHours.isOpen,
                onChanged: onCheckboxChanged,
              activeColor: Theme.of(context).primaryColor,
              fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
            ),
            const SizedBox(width: 10,),
            SizedBox(width:100,child: Text(openingHours.day,style: Theme.of(context).textTheme.headline5,)),
          ],
        );
  }

  RangeSlider _buildSlider(BuildContext context){
    return RangeSlider(
      activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.green[100],
        values: RangeValues(
          openingHours.openAt,openingHours.closeAt,
        ),
        min: 0,max: 24,
        divisions:24,
        onChanged: onSliderChanged
    );
  }

}