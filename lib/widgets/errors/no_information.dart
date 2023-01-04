part of '../widgets.dart';

class NoInformation extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool showButton;
  final String? buttonText;
  final VoidCallback? onPressed;
  final IconData iconButton;

  const NoInformation({
    Key? key,
    required this.icon,
    required this.text,
    required this.showButton,
    required this.iconButton,
    this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final getDarkTheme = Provider.of<ThemeChanger>(context).getDarkTheme; */
    return Container(
      /* color: Colors.yellow, */
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 150, color: Colors.black),
            SimpleText(
              text: text,
              top: 10,
              bottom: 10,
            ),
            showButton
                ? Row(
                    /* mainAxisAlignment: MainAxisAlignment.center, */
                    children: [
                      Expanded(
                        child: LoginButton(
                          onPressed: () {},
                          paddingVertical: 12,
                          spaceBetweenIconAndText: 15,
                          label: buttonText ?? 'Text del boton',
                          fontSize: 15,
                          ghostButton: true,
                          backGroundColor: Colors.blue,
                          icon: iconButton,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
