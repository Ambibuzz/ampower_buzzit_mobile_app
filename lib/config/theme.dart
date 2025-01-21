import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const primarycolor = Color(0xFF002D4C);
  static TextTheme textTheme = TextTheme(
      displayLarge: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5)),
      displayMedium: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5)),
      displaySmall: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 48, fontWeight: FontWeight.w400, letterSpacing: 0.0)),
      headlineMedium: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25)),
      headlineSmall: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0.0)),
      titleLarge: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15)),
      titleMedium: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15)),
      titleSmall: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.15)),
      bodyLarge: GoogleFonts.dmSans(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5)),
      bodyMedium:
          GoogleFonts.dmSans(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25)),
      labelLarge: GoogleFonts.dmSans(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25)),
      bodySmall: GoogleFonts.dmSans(textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4)),
      labelSmall: GoogleFonts.dmSans(textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5)));

  static TextStyle appBarTitleTextStyle = GoogleFonts.dmSans(
      textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: primarycolor,
  ));

  static TextStyle dialogTitleTextStyle = GoogleFonts.dmSans(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15));

  static TextStyle dialogContentTextStyle = GoogleFonts.dmSans(
      textStyle: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4));

  static TextStyle buttonTextStyle = GoogleFonts.dmSans(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.15));

  static const buttonPadding = EdgeInsets.symmetric(
      horizontal: Sizes.horizontalSmallPadding,
      vertical: Sizes.verticalExtraSmallPadding);

  static const buttonShape =
      RoundedRectangleBorder(borderRadius: Corners.xxlBorder);

  static const buttonShapeWithBorder = RoundedRectangleBorder(
    borderRadius: Corners.xxlBorder,
    side: BorderSide(color: Colors.white, width: 1),
  );

  static const buttonBorder = Corners.xxlBorder;

  static const double elevation = 3;

  static const double dividerThickness = 1;

  static double iconSize = FontSizes.s24;

  static Color fillColorGrey = const Color(0xFFF3F3F3);

  // static final Color primarycolor = Palette.primaryColor;

  //Light Theme
  // static Color backgroundColorLight = Palette.backgroundColor;
  // static Color backgroundColorLight = Colors.white;
  static Color backgroundColorLight = const Color(0xFFFAFAFA);

  // static Color backgroundColorLight = Palette.bgColor;
  static Brightness brightnessLight = Brightness.light;
  static Color disabledColorLight = const Color(0xFFA5A5A5);
  static Color dangerColor = const Color(0xFFBE2527);
  static Color errorColorLight = const Color(0xFFE33629);
  static Color appBarIconThemeColorLight = const Color(0xFFFFFFFF);
  static Color onBackgroundColorLight = const Color(0xFF000000);
  static Color onErrorColorLight = const Color(0xFFFFFFFF);
  static Color onPrimaryColorLight = const Color(0xFFFFFFFF);
  static Color onSecondaryColorLight = const Color(0xFFFFFFFF);
  static Color onSurfaceColorLight = const Color(0xFF000000);
  static Color primaryColorLight = primarycolor;

  // static Color primaryColorLight =Color(0xFF53B175);
  // static Color primaryColorLight = Color(0xFF6200EE);
  static Color primaryVariantLight = const Color(0xFF3700B3);
  static Color secondaryColorLight = const Color(0xFFFF731D);
  static Color secondaryVariantLight = const Color(0xFF018786);
  static Color surfaceColorLight = const Color(0xFFFFFFFF);

  //Dark Theme
  static Color backgroundColorDark = const Color(0xFF121212);
  static Brightness brightnessDark = Brightness.dark;
  static Color disabledColorDark = const Color(0xFFA5A5A5);
  static Color errorColorDark = const Color(0xFFCF6679);
  static Color onBackgroundColorDark = const Color(0xFFFFFFFF);
  static Color onErrorColorDark = const Color(0xFF000000);
  static Color onPrimaryColorDark = const Color(0xFF000000);
  static Color onSecondaryColorDark = const Color(0xFF000000);
  static Color onSurfaceColorDark = const Color(0xFFFFFFFF);
  static Color primaryColorDark = const Color(0xFFBB86FC);
  static Color primaryVariantDark = const Color(0xFF3700B3);
  static Color secondaryColorDark = const Color(0xFF03DAC6);
  static Color secondaryVariantDark = const Color(0xFF03DAC6);
  static Color surfaceColorDark = const Color(0xFF424242);

  //Chart Color Data
  static Color chartColorTarget = primaryColorLight;
  static Color chartColorAchievement = const Color(0xFFFF731D);
  static Color chartColorPrediction = Colors.green;
  static Color tableHeaderColor = const Color(0xFFD6D6D6);

  static var dropdownColor = const Color(0xFFD9D9D9);
  static var toastMessageBgColor = const Color(0xFFB0D1E8);
  static var iconColor = const Color(0xFF666666);
  static var borderColor = const Color(0xFF666666);
  static var toastSuccessColor = const Color(0xFF67DE81);

  static ThemeData lightTheme({Color? primaryColor}) {
    return ThemeData(
      textTheme: textTheme,
      scaffoldBackgroundColor: backgroundColorLight,
      disabledColor: disabledColorLight,
      primaryColor: primaryColor ?? primaryColorLight,
      brightness: brightnessLight,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColorLight,
        titleTextStyle: appBarTitleTextStyle,
        surfaceTintColor: backgroundColorLight,
        actionsIconTheme:
            IconThemeData(color: appBarIconThemeColorLight, size: iconSize),
        iconTheme:
            IconThemeData(color: appBarIconThemeColorLight, size: iconSize),
        elevation: elevation,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: secondaryColorLight ?? secondaryColorLight,
        disabledColor: disabledColorLight,
        textTheme: ButtonTextTheme.primary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        surfaceTintColor: surfaceColorLight,
        backgroundColor: surfaceColorLight,
      ),
      cardTheme: CardTheme(
          color: surfaceColorLight,
          elevation: elevation,
          surfaceTintColor: surfaceColorLight,
          shape: const RoundedRectangleBorder(borderRadius: Corners.xxlBorder)),
      checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(onBackgroundColorLight),
          fillColor: MaterialStateProperty.all(backgroundColorLight),
          side: BorderSide(color: onBackgroundColorLight, width: 1)),
      dataTableTheme: DataTableThemeData(
        decoration: BoxDecoration(
            color: surfaceColorLight, borderRadius: Corners.xlBorder),
      ),
      dialogTheme: DialogTheme(
          backgroundColor: backgroundColorLight,
          titleTextStyle:
              dialogTitleTextStyle.copyWith(color: onSurfaceColorLight),
          contentTextStyle:
              dialogContentTextStyle.copyWith(color: onSurfaceColorLight),
          elevation: elevation),
      dialogBackgroundColor: backgroundColorLight,
      dividerColor: const Color(0xFFE7E5E5),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE7E5E5),
        thickness: dividerThickness,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              secondaryColorLight ?? secondaryColorLight),
          elevation: const WidgetStatePropertyAll(elevation),
          padding: const WidgetStatePropertyAll(buttonPadding),
          textStyle: WidgetStatePropertyAll(buttonTextStyle),
          shape: const WidgetStatePropertyAll(buttonShape),
          foregroundColor: WidgetStatePropertyAll(onPrimaryColorLight),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor ?? primaryColorLight,
        foregroundColor: onSecondaryColorLight,
        disabledElevation: elevation,
        elevation: elevation,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: backgroundColorLight,
        textColor: Colors.black,
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        collapsedBackgroundColor: backgroundColorLight,
        collapsedTextColor: Colors.black,
        // shape: const RoundedRectangleBorder(borderRadius: Corners.xlBorder),
      ),
      iconTheme: IconThemeData(color: onBackgroundColorLight, size: iconSize),
      inputDecorationTheme: InputDecorationTheme(
        // fillColor: surfaceColorLight,
        fillColor: backgroundColorLight,
        filled: true,
        isDense: false,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
          borderRadius: Corners.xxlBorder,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColorLight,
          ),
          borderRadius: Corners.xxlBorder,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor ?? primaryColorLight,
          ),
          borderRadius: Corners.xxlBorder,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColorLight,
          ),
          borderRadius: Corners.xxlBorder,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(primaryColor ?? primaryColorLight),
          elevation: MaterialStateProperty.all(elevation),
          textStyle: MaterialStateProperty.all(buttonTextStyle),
          padding: MaterialStateProperty.all(buttonPadding),
          shape: MaterialStateProperty.all(buttonShapeWithBorder),
          foregroundColor: MaterialStateProperty.all(onPrimaryColorLight),
        ),
      ),
      primaryIconTheme: IconThemeData(
          color: primaryColor ?? primaryColorLight, size: iconSize),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: onBackgroundColorLight,
        actionTextColor: backgroundColorLight,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(secondaryColorLight),
          elevation: MaterialStateProperty.all(elevation),
          textStyle: MaterialStateProperty.all(buttonTextStyle),
          padding: MaterialStateProperty.all(buttonPadding),
          shape: MaterialStateProperty.all(buttonShape),
          foregroundColor: MaterialStateProperty.all(onPrimaryColorLight),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme(
              primary: primaryColor ?? primaryColorLight,
              secondary: secondaryColorLight,
              surface: surfaceColorLight,
              background: backgroundColorLight,
              error: errorColorLight,
              onPrimary: onPrimaryColorLight,
              onSecondary: onSecondaryColorLight,
              onSurface: onBackgroundColorLight,
              onBackground: onBackgroundColorLight,
              onError: onErrorColorLight,
              brightness: brightnessLight)
          .copyWith(background: backgroundColorLight)
          .copyWith(error: errorColorLight),
    );
  }

  static ThemeData darkTheme({Color? primaryColor}) {
    return ThemeData(
      textTheme: textTheme,
      scaffoldBackgroundColor: backgroundColorDark,
      disabledColor: disabledColorDark,
      primaryColor: primaryColor ?? primaryColorDark,
      brightness: brightnessDark,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColorDark,
        titleTextStyle: appBarTitleTextStyle,
        actionsIconTheme:
            IconThemeData(color: onBackgroundColorDark, size: iconSize),
        iconTheme: IconThemeData(color: onBackgroundColorDark, size: iconSize),
        elevation: elevation,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor ?? primaryColorDark,
        disabledColor: disabledColorDark,
        textTheme: ButtonTextTheme.primary,
      ),
      cardTheme: CardTheme(color: surfaceColorDark, elevation: elevation),
      checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(onBackgroundColorDark),
          fillColor: MaterialStateProperty.all(backgroundColorDark),
          side: BorderSide(color: onBackgroundColorDark, width: 1)),
      dataTableTheme: DataTableThemeData(
        decoration: BoxDecoration(
            color: surfaceColorDark, borderRadius: Corners.medBorder),
      ),
      dialogTheme: DialogTheme(
          backgroundColor: backgroundColorDark,
          titleTextStyle:
              dialogTitleTextStyle.copyWith(color: onSurfaceColorDark),
          contentTextStyle:
              dialogContentTextStyle.copyWith(color: onSurfaceColorDark),
          elevation: elevation),
      dialogBackgroundColor: backgroundColorDark,
      dividerColor: onBackgroundColorDark,
      dividerTheme: DividerThemeData(
        color: onBackgroundColorDark,
        thickness: dividerThickness,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(primaryColor ?? primaryColorDark),
          elevation: MaterialStateProperty.all(elevation),
          padding: MaterialStateProperty.all(buttonPadding),
          textStyle: MaterialStateProperty.all(buttonTextStyle),
          shape: MaterialStateProperty.all(buttonShape),
          foregroundColor: MaterialStateProperty.all(onPrimaryColorDark),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: backgroundColorDark,
        textColor: Colors.white,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        collapsedBackgroundColor: backgroundColorDark,
        collapsedTextColor: Colors.white,
        // shape: const RoundedRectangleBorder(borderRadius: Corners.xxlBorder),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor ?? primaryColorDark,
        foregroundColor: onSecondaryColorDark,
        disabledElevation: elevation,
        elevation: elevation,
      ),
      iconTheme: IconThemeData(color: onBackgroundColorDark, size: iconSize),
      inputDecorationTheme: InputDecorationTheme(
        // fillColor: surfaceColor,
        filled: true,
        isDense: false,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: Corners.xxlBorder,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColorDark,
          ),
          borderRadius: Corners.xxlBorder,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor ?? primaryColorDark,
          ),
          borderRadius: Corners.xxlBorder,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColorDark,
          ),
          borderRadius: Corners.xxlBorder,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(primaryColor ?? primaryColorDark),
          elevation: MaterialStateProperty.all(elevation),
          textStyle: MaterialStateProperty.all(buttonTextStyle),
          padding: MaterialStateProperty.all(buttonPadding),
          shape: MaterialStateProperty.all(buttonShapeWithBorder),
          foregroundColor: MaterialStateProperty.all(onPrimaryColorDark),
        ),
      ),
      primaryIconTheme: IconThemeData(
          color: primaryColor ?? primaryColorDark, size: iconSize),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(primaryColor ?? primaryColorDark),
            elevation: MaterialStateProperty.all(elevation),
            textStyle: MaterialStateProperty.all(buttonTextStyle),
            padding: MaterialStateProperty.all(buttonPadding),
            shape: MaterialStateProperty.all(buttonShape),
            foregroundColor: MaterialStateProperty.all(onPrimaryColorDark)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: onBackgroundColorDark,
        actionTextColor: backgroundColorDark,
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(
          fillColor: primaryColor ?? primaryColorDark,
          borderColor: onBackgroundColorDark,
          selectedBorderColor: onBackgroundColorDark,
          selectedColor: primaryColor ?? primaryColorDark),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme(
              primary: primaryColor ?? primaryColorDark,
              secondary: secondaryColorDark,
              surface: surfaceColorDark,
              background: backgroundColorDark,
              error: errorColorDark,
              onPrimary: onPrimaryColorDark,
              onSecondary: onSecondaryColorDark,
              onSurface: onBackgroundColorDark,
              onBackground: onBackgroundColorDark,
              onError: onErrorColorDark,
              brightness: brightnessDark)
          .copyWith(background: backgroundColorDark)
          .copyWith(error: errorColorDark),
    );
  }
}
