part of '../widgets.dart';

class GlobalSnackBar {
  final String message;
  const GlobalSnackBar({
    required this.message,
  });

  static show(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: SimpleText(
          text: message,
          lightThemeColor: Colors.white,
          setUniqueColor: true,
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
