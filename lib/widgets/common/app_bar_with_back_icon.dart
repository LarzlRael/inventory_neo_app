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
    final authProvider = context.read<AuthProvider>();
    return AppBar(
      elevation: 0,
      title: showTitle
          ? Hero(
              tag: title!,
              child: Material(
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          : appBarTitle(subTitle, authProvider),
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left_rounded,
          size: 35,
        ),
        onPressed: context.pop,
      ),
      actions: [
        ...?actions,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

Widget appBarTitle(String? subTitle, AuthProvider? authProvider) {
  return Column(
    children: [
      /*  SimpleText(
        text: authProvider.user!.client!.store!.name!,
        lightThemeColor: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ), */
      const SizedBox(
        height: 3,
      ),
      Text(
        subTitle ?? 'Propietario',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );
}

Widget appBarWithTitle(String? subTitle, AuthProvider? authProvider) {
  return Text(
    subTitle ?? 'Propietario',
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  );
}
