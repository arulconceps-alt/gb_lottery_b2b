import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData? _themeData;
  static Map<String, dynamic>? _jsonMap;

  static ThemeData get theme => _themeData ?? _defaultTheme;
  static Map<String, dynamic>? get rawTheme => _jsonMap;

  static Future<void> init() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/theme/app_theme.json');
      _jsonMap = jsonDecode(jsonString);
      _themeData = _parseThemeData(_jsonMap!);
      TextStyles.updateFromTheme(_themeData!);
    } catch (e) {
      debugPrint('Error loading theme: $e');
      _themeData = _defaultTheme;
      TextStyles.updateFromTheme(_themeData!);
    }
  }

  static ThemeData _parseThemeData(Map<String, dynamic> json) {
    final colorSchemeJson = json['colorScheme'] as Map<String, dynamic>?;
    final appBarJson = json['appBarTheme'] as Map<String, dynamic>?;
    final bottomNavJson = json['bottomNavigationBarTheme'] as Map<String, dynamic>?;
    final textThemeJson = json['textTheme'] as Map<String, dynamic>?;

    final primaryColor = _parseColor(json['primaryColor'] ?? json['colorScheme']?['primary']);
    final scaffoldBackgroundColor = _parseColor(json['scaffoldBackgroundColor'] ?? json['canvasColor']);

    // Parse TextTheme correctly
    final textTheme = textThemeJson != null ? _parseTextTheme(textThemeJson) : GoogleFonts.dmSansTextTheme();

    return ThemeData(
      useMaterial3: json['useMaterial3'] ?? true,
      brightness: json['brightness'] == 'dark' ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: _parseColor(json['canvasColor']),
      cardColor: _parseColor(json['cardColor']),
      dividerColor: _parseColor(json['dividerColor']),
      hintColor: _parseColor(json['hintColor']),
      
      colorScheme: colorSchemeJson != null ? ColorScheme(
        brightness: colorSchemeJson['brightness'] == 'dark' ? Brightness.dark : Brightness.light,
        primary: _parseColor(colorSchemeJson['primary']),
        onPrimary: _parseColor(colorSchemeJson['onPrimary']),
        primaryContainer: _parseColor(colorSchemeJson['primaryContainer']),
        onPrimaryContainer: _parseColor(colorSchemeJson['onPrimaryContainer']),
        secondary: _parseColor(colorSchemeJson['secondary']),
        onSecondary: _parseColor(colorSchemeJson['onSecondary']),
        secondaryContainer: _parseColor(colorSchemeJson['secondaryContainer']),
        onSecondaryContainer: _parseColor(colorSchemeJson['onSecondaryContainer']),
        tertiary: _parseColor(colorSchemeJson['tertiary']),
        onTertiary: _parseColor(colorSchemeJson['onTertiary']),
        tertiaryContainer: _parseColor(colorSchemeJson['tertiaryContainer']),
        onTertiaryContainer: _parseColor(colorSchemeJson['onTertiaryContainer']),
        error: _parseColor(colorSchemeJson['error']),
        onError: _parseColor(colorSchemeJson['onError']),
        errorContainer: _parseColor(colorSchemeJson['errorContainer']),
        onErrorContainer: _parseColor(colorSchemeJson['onErrorContainer']),
        surface: _parseColor(colorSchemeJson['surface']),
        onSurface: _parseColor(colorSchemeJson['onSurface']),
        surfaceContainerHighest: _parseColor(colorSchemeJson['surfaceContainerHighest']),
        outline: _parseColor(colorSchemeJson['outline']),
        outlineVariant: _parseColor(colorSchemeJson['outlineVariant']),
        shadow: _parseColor(colorSchemeJson['shadow']),
        scrim: _parseColor(colorSchemeJson['scrim']),
        inverseSurface: _parseColor(colorSchemeJson['inverseSurface']),
        onInverseSurface: _parseColor(colorSchemeJson['onInverseSurface']),
        inversePrimary: _parseColor(colorSchemeJson['inversePrimary']),
        surfaceVariant: _parseColor(colorSchemeJson['surfaceVariant']),
        onSurfaceVariant: _parseColor(colorSchemeJson['onSurfaceVariant']),
      ) : null,

      appBarTheme: appBarJson != null ? AppBarTheme(
        backgroundColor: _parseColor(appBarJson['backgroundColor']),
        elevation: (appBarJson['elevation'] as num?)?.toDouble(),
        centerTitle: appBarJson['centerTitle'],
        iconTheme: appBarJson['iconTheme'] != null ? IconThemeData(
          color: _parseColor(appBarJson['iconTheme']['color']),
          size: (appBarJson['iconTheme']['size'] as num?)?.toDouble(),
        ) : null,
      ) : null,

      bottomNavigationBarTheme: bottomNavJson != null ? BottomNavigationBarThemeData(
        backgroundColor: _parseColor(bottomNavJson['backgroundColor']),
        selectedItemColor: _parseColor(bottomNavJson['selectedItemColor']),
        unselectedItemColor: _parseColor(bottomNavJson['unselectedItemColor']),
        elevation: (bottomNavJson['elevation'] as num?)?.toDouble(),
      ) : null,

      textTheme: textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }

  static TextTheme _parseTextTheme(Map<String, dynamic> json) {
    return TextTheme(
      displayLarge: _parseTextStyle(json['displayLarge']),
      displayMedium: _parseTextStyle(json['displayMedium']),
      displaySmall: _parseTextStyle(json['displaySmall']),
      headlineLarge: _parseTextStyle(json['headlineLarge']),
      headlineMedium: _parseTextStyle(json['headlineMedium']),
      headlineSmall: _parseTextStyle(json['headlineSmall']),
      titleLarge: _parseTextStyle(json['titleLarge']),
      titleMedium: _parseTextStyle(json['titleMedium']),
      titleSmall: _parseTextStyle(json['titleSmall']),
      bodyLarge: _parseTextStyle(json['bodyLarge']),
      bodyMedium: _parseTextStyle(json['bodyMedium']),
      bodySmall: _parseTextStyle(json['bodySmall']),
      labelLarge: _parseTextStyle(json['labelLarge']),
      labelMedium: _parseTextStyle(json['labelMedium']),
      labelSmall: _parseTextStyle(json['labelSmall']),
    );
  }

  static TextStyle? _parseTextStyle(Map<String, dynamic>? json) {
    if (json == null) return null;
    final fontFamily = json['fontFamily'] as String?;
    final fontSize = (json['fontSize'] as num?)?.toDouble();
    final fontWeight = _parseFontWeight(json['fontWeight'] as String?);
    final height = (json['height'] as num?)?.toDouble();
    final letterSpacing = (json['letterSpacing'] as num?)?.toDouble();
    final color = _parseColor(json['color'] as String?);
    
    return GoogleFonts.getFont(
      fontFamily ?? 'DM Sans',
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color == Colors.transparent ? null : color,
    );
  }

  static FontWeight? _parseFontWeight(String? weight) {
    switch (weight) {
      case 'w100': return FontWeight.w100;
      case 'w200': return FontWeight.w200;
      case 'w300': return FontWeight.w300;
      case 'w400': return FontWeight.w400;
      case 'w500': return FontWeight.w500;
      case 'w600': return FontWeight.w600;
      case 'w700': return FontWeight.w700;
      case 'w800': return FontWeight.w800;
      case 'w900': return FontWeight.w900;
      default: return null;
    }
  }

  static Color _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return Colors.transparent;
    if (colorString.startsWith('#')) {
      final buffer = StringBuffer();
      // Handle #ffrrggbb or #rrggbb
      if (colorString.length == 7) buffer.write('ff');
      if (colorString.length == 9) {
         // Already has alpha
         buffer.write(colorString.replaceFirst('#', ''));
      } else {
         buffer.write(colorString.replaceFirst('#', ''));
      }
      try {
        return Color(int.parse(buffer.toString(), radix: 16));
      } catch (e) {
        return Colors.transparent;
      }
    }
    return Colors.transparent;
  }

  static final ThemeData _defaultTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1C1B20),
    primaryColor: const Color(0xFFDFC55C),
    textTheme: GoogleFonts.dmSansTextTheme(),
  );

  static ThemeData of(BuildContext context) => Theme.of(context);
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}

class theme {
  static _ThemeContext get context => _ThemeContext();
}

class _ThemeContext {
  ThemeData of(BuildContext context) => Theme.of(context);
}
