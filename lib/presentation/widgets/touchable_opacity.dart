import 'package:flutter/material.dart';

class TouchableOpacity extends StatefulWidget {
  final Widget child;
  final Function()? onTap;
  final Duration duration = const Duration(milliseconds: 12);


  const TouchableOpacity({Key? key, required this.child, this.onTap,}) : super(key: key);

  @override
  State<TouchableOpacity> createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  bool down = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => down = true),
      onTapUp: (_) => setState(() => down = false),
      onTapCancel: () => setState(() => down = false),
      onTap: widget.onTap,
      child: AnimatedOpacity(
        opacity: down ? 0.5 : 1.0,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
