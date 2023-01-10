import 'package:flutter/material.dart';

import '../../core/utils/styles.dart';

class QuantityCount extends StatefulWidget {
  final Color? buttonColor;
  final Color? backgroundColor;
  final double? radius;
  final Function(int)? itemCountChange;
  final int initCount;

  const QuantityCount({
    Key? key,
    this.itemCountChange,
    this.buttonColor,
    this.backgroundColor,
    this.radius,
    this.initCount = 1,
  }) : super(key: key);

  @override
  State<QuantityCount> createState() => _QuantityCountState();
}

class _QuantityCountState extends State<QuantityCount> {
  int count = 1;

  @override
  void initState() {
    count = widget.initCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(widget.radius ?? 0.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: decrease,
              icon: Icon(
                Icons.remove,
                color: widget.buttonColor ?? AppColors.lightYellow,
              ),
            ),
            SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  '$count',
                  style: AppTextStyle.medium.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: increase,
              icon: Icon(
                Icons.add,
                color: widget.buttonColor ?? AppColors.lightYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void decrease() {
    if (count > 1) {
      setState(() {
        count--;
        widget.itemCountChange!(count);
      });
    }
  }

  void increase() {
    setState(() {
      count++;
      widget.itemCountChange!(count);
    });
  }
}