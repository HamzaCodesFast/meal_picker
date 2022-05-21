import 'package:flutter/material.dart';

// light

final Color blackColor = Color(0xFF000000);
final Color whiteColor = Color(0xFFFFFFFF);
final Color darkGrey12Color = Color(0x1F1F1F1F); // background color disabled buttons

final Color primaryColor = Color(0xFF9D4140);
final Color onPrimaryColor = Color(0xFFFFFFFF);
final Color primaryContainerColor = Color(0xFFFFDAD6);
final Color onPrimaryContainerColor = Color(0xFF400005);

final Color secondaryColor = Color(0xFF775654);
final Color onSecondaryColor = Color(0xFFFFDAD7);
final Color secondaryContainerColor = Color(0xFF2D1514);
final Color onSecondaryContainerColor = Color(0xFF2D1514);

final Color tertiaryColor = Color(0xFF735A2E);
final Color onTertiaryColor = Color(0xFFFFFFFF);
final Color tertiaryContainerColor = Color(0xFFFFDEA7);
final Color onTertiaryContainerColor = Color(0xFF281900);

final Color errorColor = Color(0xFFBA1B1B);
final Color successColor = Color(0xFF138A81);
final Color onErrorColor = Color(0xFFFFFFFF);
final Color errorContainerColor = Color(0xFFFFDAD4);
final Color onErrorContainerColor = Color(0xFF410001);

final Color backgroundColor = Color(0xFFFCFCFC);
final Color onBackgroundColor = Color(0xFF201A1A);
final Color surfaceColor = Color(0xFFFCFCFC);
final Color onSurfaceColor = Color(0xFF201A1A);
final Color surfaceVariantColor = Color(0xFFF4DDDB);
final Color onSurfaceVariantColor = Color(0xFF524342);
final Color outlineColor = Color(0xFF857372);

// read only

final Color surface2Color = alphaBlend(Color(0x149D4140), Color(0xFFFCFCFC));


Color alphaBlend(Color foreground, Color background) {
  final int alpha = foreground.alpha;
  if (alpha == 0x00) {
    // Foreground completely transparent.
    return background;
  }
  final int invAlpha = 0xff - alpha;
  int backAlpha = background.alpha;
  if (backAlpha == 0xff) {
    // Opaque background case
    return Color.fromARGB(
      0xff,
      (alpha * foreground.red + invAlpha * background.red) ~/ 0xff,
      (alpha * foreground.green + invAlpha * background.green) ~/ 0xff,
      (alpha * foreground.blue + invAlpha * background.blue) ~/ 0xff,
    );
  } else {
    // General case
    backAlpha = (backAlpha * invAlpha) ~/ 0xff;
    final int outAlpha = alpha + backAlpha;
    assert(outAlpha != 0x00);
    return Color.fromARGB(
      outAlpha,
      (foreground.red * alpha + background.red * backAlpha) ~/ outAlpha,
      (foreground.green * alpha + background.green * backAlpha) ~/ outAlpha,
      (foreground.blue * alpha + background.blue * backAlpha) ~/ outAlpha,
    );
  }
}