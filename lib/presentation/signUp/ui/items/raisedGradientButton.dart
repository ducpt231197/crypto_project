import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const RaisedGradientButton({
    Key? key,
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
          // borderRadius: new BorderRadius.only(
          //   topLeft: const Radius.circular(10.0),
          //   topRight: const Radius.circular(10.0),
          // )
          borderRadius: new BorderRadius.all(Radius.circular(5))
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
