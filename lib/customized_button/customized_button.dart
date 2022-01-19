import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GradientOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;
  final Icon _icon;
  EdgeInsets padding;
  EdgeInsets margin;

  // ignore: use_key_in_widget_constructors
  GradientOutlineButton(
      {double strokeWidth = 4,
      @required Gradient? gradient,
      @required double? radius,
      @required Widget? child,
      @required Icon? icon,
      @required VoidCallback? onPressed,
      required this.padding,
      required this.margin})
      // ignore: unnecessary_this
      : this._painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius!, gradient: gradient!),
        // ignore: unnecessary_this
        this._child = child!,
        // ignore: unnecessary_this
        this._icon = icon!,
        // ignore: unnecessary_this
        this._callback = onPressed!,
        // ignore: unnecessary_this
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            // ignore: prefer_if_null_operators
            padding: padding != null
                ? padding
                : const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            // ignore: prefer_if_null_operators
            margin: margin != null
                ? margin
                : const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            constraints: const BoxConstraints(minWidth: 88, minHeight: 48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _icon,
                const SizedBox(
                  width: 8,
                ),
                _child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {@required double? strokeWidth,
      @required double? radius,
      @required Gradient? gradient})
      // ignore: unnecessary_this
      : this.strokeWidth = strokeWidth!,
        // ignore: unnecessary_this
        this.radius = radius!,
        // ignore: unnecessary_this
        this.gradient = gradient!;

  @override
  void paint(Canvas canvas, Size size) {
    // ignore: avoid_print
    print("radius : $radius");
    // ignore: avoid_print
    print("strokeWidth : $strokeWidth");

    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
