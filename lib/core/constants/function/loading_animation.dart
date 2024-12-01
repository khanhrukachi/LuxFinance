import 'package:flutter/material.dart';

void loadingAnimation(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allow dismissing by tapping outside
    builder: (context) {
      // AnimationController for continuous animation
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent, // Make the dialog background transparent
            elevation: 0, // Remove shadow for the dialog
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Remove gradient and use transparent or solid color background
                  Container(
                    color: Colors.transparent, // You can set a solid color if needed
                  ),
                  // Animated rotating circle using an AnimationController
                  RotationAnimationWidget(),
                  // Border circle
                  Container(
                    width: 73,
                    height: 73,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class RotationAnimationWidget extends StatefulWidget {
  @override
  _RotationAnimationWidgetState createState() =>
      _RotationAnimationWidgetState();
}

class _RotationAnimationWidgetState extends State<RotationAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Loop the animation indefinitely
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159265359, // Rotate over 360 degrees
          child: child,
        );
      },
      child: Container(
        width: 73,
        height: 73,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [
              Colors.grey.withOpacity(0.9),
              Colors.grey.withOpacity(0.3),
              Colors.transparent,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
