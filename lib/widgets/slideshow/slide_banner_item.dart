part of '../widgets.dart';

class SlideBannerItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetImage;
  final double titleSize;
  final double subtitleSize;

  const SlideBannerItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.assetImage,
    this.titleSize = 16.0,
    this.subtitleSize = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.network(
            assetImage,
            fit: BoxFit.cover,
          ),
        ),
        SimpleText(
          text: title,
          fontSize: titleSize,
          /* color: Colors.black,
          darkThemeColor: Colors.white, */
          bottom: 10,
          top: 10,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
        SimpleText(
          text: subtitle,
          fontSize: subtitleSize,
          /* color: Colors.black,
          darkThemeColor: Colors.white, */
          textAlign: TextAlign.center,
          left: 20,
          right: 20,
        ),
      ],
    );
  }
}
