import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? buttonColor, labelColor, iconColor;
  final IconData? iconData;
  final Function() onTap;
  const CustomButton({
    super.key,
    this.text,
    required this.onTap,
    this.buttonColor,
    this.labelColor,
    this.iconColor,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: Color.fromARGB(255, 17, 107, 180),
            ),
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
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: labelColor ?? Colors.white),
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
