import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';

import '../../core/utils/app_utils.dart';

class CheckboxTile extends StatefulWidget {
  final String text;
  final Function(bool)? onCheckChanged;
  const CheckboxTile({Key? key, required this.text,this.onCheckChanged,}) : super(key: key);

  @override
  State<CheckboxTile> createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  bool checked = false;


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(!checked)
          IconButton(
              onPressed: onCheckChanged,
              icon: const Icon(Icons.check_box_outline_blank_outlined, color: Colors.grey,)),
        if(checked)
          IconButton(
            onPressed: onCheckChanged,
            icon: Image.asset(AppImages.icChecked,),
          ),
        const SizedBox(width: 16,),
        Text(
          widget.text,
          style: AppTextStyle.normal.copyWith(
            fontSize: 16,
          ),
        )
      ],
    );
  }

  void onCheckChanged(){
    setState(() {
      checked = !checked;
      if(widget.onCheckChanged != null){
        widget.onCheckChanged!(checked);
      }
    });
  }
}
