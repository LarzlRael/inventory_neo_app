part of '../widgets.dart';

class AppBarWithBackIcon extends StatelessWidget
    implements PreferredSizeWidget {
  final AppBar appBar;
  final String? title;
  final bool showTitle;
  final String? subTitle;
  final List<Widget>? actions;
  const AppBarWithBackIcon({
    Key? key,
    this.title,
    this.subTitle,
    this.showTitle = false,
    this.actions,
    required this.appBar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /* final theme = Provider.of<ThemeChanger>(context); */
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: showTitle
          ? SimpleText(
              text: title!,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )
          : appBarTitle(subTitle),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_circle_left_outlined,
          size: 40,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        ...?actions,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

Widget appBarTitle(String? subTitle) {
  return Column(
    children: [
      SimpleText(
        text: 'Joyeria Arrieta',
        lightThemeColor: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      const SizedBox(
        height: 3,
      ),
      SimpleText(
        text: subTitle ?? 'Propietario',
        lightThemeColor: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ],
  );
}
