part of '../widgets.dart';

Widget simpleLoading() {
  return const Expanded(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget simpleLoadingWithScaffold() {
  return Scaffold(
    body: Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
