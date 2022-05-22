import 'package:flutter/material.dart';
import 'package:meal_picker/infrastructure/theme/theme_colors.dart';
import 'package:meal_picker/infrastructure/theme/theme_typo.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onPressed;
  final bool enabled;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.enabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: enabled ? onPrimaryColor : onSurfaceColor.withOpacity(0.38), //enabled einfügen überall
      ),
      label: Text(
        label,
        style: labelLargeTypo.copyWith(color: enabled ? onPrimaryColor : onSurfaceColor.withOpacity(0.38)),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(enabled ? primaryColor : darkGrey12Color),
        padding: MaterialStateProperty.all(const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 24)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide.none),
        ),
      ),
    );
  }
}
