import 'package:couple_planet/core/auth_check.dart';
import 'package:couple_planet/core/route_generator.dart';
import 'package:couple_planet/res/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFire Samples',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: Palette.textColor,
          secondary: Palette.googleBackground,
          onPrimary: Palette.firebaseYellow,
          onSecondary: Palette.kToDark,
          onSurface: Palette.kToDark,
          onBackground: Palette.kToDark,
          onError: Palette.kToDark,
          surface: Palette.kToDark,
          background: Palette.kToDark,
          error: Palette.kToDark,
        ),
        primarySwatch: Palette.kToDark,
        textTheme: GoogleFonts.timmanaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: PaletteDark.textColor,
          secondary: PaletteDark.googleBackground,
          onPrimary: Palette.kToDark,
          onSecondary: Palette.kToDark,
          onSurface: Palette.kToDark,
          onBackground: Palette.kToDark,
          onError: Palette.kToDark,
          surface: Palette.kToDark,
          background: Palette.kToDark,
          error: Palette.kToDark,
        ),
        brightness: Brightness.dark,
        primarySwatch: PaletteDark.kToDark,
        textTheme: GoogleFonts.timmanaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const AuthCheck(),
    );
  }
}
