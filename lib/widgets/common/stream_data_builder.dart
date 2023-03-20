part of '../widgets.dart';

class StreamDataBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(T data) builder;
  final NoInformation noResultsWidget;

  const StreamDataBuilder({
    super.key,
    required this.stream,
    required this.builder,
    required this.noResultsWidget,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data is List && (snapshot.data as List).isEmpty) {
          return noResultsWidget;
        }
        return builder(snapshot.data!);
      },
    );
  }
}
