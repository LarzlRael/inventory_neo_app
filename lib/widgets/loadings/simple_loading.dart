part of '../widgets.dart';

Widget simpleLoading({double strokeWith = 4.0, Color? color}) {
  return Expanded(
    child: Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWith,
        color: color,
      ),
    ),
  );
}

Widget simpleLoadingWithScaffold() {
  return Scaffold(
    body: Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
