part of '../widgets.dart';

Widget simpleLoading() {
  return const Expanded(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget simpleLoadingWithScaffold() {
  return const Scaffold(
    body: Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
