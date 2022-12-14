import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.onPressed,
    this.radius = 10,
    required this.text,
  });

  final Color color;
  final VoidCallback onPressed;
  final double radius;
  final String text;

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xffffffff);

    return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                  const Size.fromWidth(double.maxFinite),),
              elevation: MaterialStateProperty.all(0),
              alignment: Alignment.center,
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),),
              ),),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(color: accentColor, fontSize: 16),
          ),
        ),);
  }
}
