part of '../widgets.dart';

class AppBarWithBackIcon extends StatelessWidget
    implements PreferredSizeWidget {
  final AppBar appBar;
  final String? title;
  const AppBarWithBackIcon({
    Key? key,
    required this.appBar,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /* final theme = Provider.of<ThemeChanger>(context); */
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: title != null
          ? SimpleText(
              text: title!,
              lightThemeColor: Colors.black,
              darkThemeColor: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          : null,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_circle_left_outlined,
          size: 40,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
