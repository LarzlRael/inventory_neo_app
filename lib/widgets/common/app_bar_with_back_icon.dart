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
      centerTitle: true,
      title: appBarTitle(),
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

Widget appBarTitle() {
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
        text: 'Propietario',
        lightThemeColor: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ],
  );
}
