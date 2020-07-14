import 'package:flutter/material.dart';

class BlinkWidget extends StatefulWidget {
  final Widget child;

  BlinkWidget({
    Key key,
    this.child,
  });

  @override
  _BlinkWidgetState createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double value = 1.0;

  initState() {
    super.initState();

    _controller = new AnimationController(
        duration: Duration(milliseconds: 800), vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (value == 1.0)
            value = 0.0;
          else
            value = 1.0;
        });
        _controller.forward(from: 0.0);
      }
    });
    _controller.forward();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Opacity(opacity: value, child: widget.child),
    );
  }
}
