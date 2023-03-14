import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? buttonColor, labelColor, iconColor;
  final IconData? iconData;
  final Function() onTap;
  final bool hasBorder;
  final double? elevation;
  final FontWeight? fontWeight;
  const CustomButton({
    super.key,
    this.text,
    required this.onTap,
    this.buttonColor,
    this.labelColor,
    this.iconColor,
    this.iconData,
    this.hasBorder = false,
    this.elevation,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: elevation ?? 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: hasBorder
                ? const BorderSide(
                    color: Color(0xFFD9D9D9),
                  )
                : BorderSide.none,
          ),
          color: buttonColor ?? Color.fromARGB(255, 17, 107, 180),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconData != null
                  ? Icon(
                      iconData,
                      color: iconColor ?? Colors.white,
                    )
                  : const SizedBox(),
              text != null
                  ? Expanded(
                      child: Text(
                        text ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: labelColor ?? Colors.white,
                            fontWeight: fontWeight ?? FontWeight.bold),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
