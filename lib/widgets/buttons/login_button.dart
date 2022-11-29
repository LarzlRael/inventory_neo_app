part of 'buttons.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color backGroundColor;
  final Color textColor;
  final IconData icon;
  final bool showIcon;
  final double marginVertical;
  final double marginHorizontal;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizontal;
  final double spaceBetweenIconAndText;
  final bool ghostButton;
  const LoginButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.backGroundColor = Colors.blue,
    this.textColor = Colors.black,
    this.icon = (Icons.person),
    this.showIcon = true,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
    this.fontSize = 17.0,
    this.paddingVertical = 15.0,
    this.paddingHorizontal = 40.0,
    this.spaceBetweenIconAndText = 10.0,
    this.ghostButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      child: ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              color: backGroundColor,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
              ghostButton ? Colors.white : backGroundColor),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: paddingHorizontal,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              /* side: BorderSide(color: Colors.red), */
            ),
          ),
        ),
        onPressed: onPressed,
        child: showIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: ghostButton ? backGroundColor : textColor,
                  ),
                  SizedBox(width: spaceBetweenIconAndText),
                  SimpleText(
                    text: label,
                    fontSize: fontSize,
                    lightThemeColor: ghostButton ? backGroundColor : textColor,
                  ),
                ],
              )
            : SizedBox(
                width: double.infinity,
                child: SimpleText(
                  text: label,
                  fontSize: fontSize,
                  lightThemeColor: ghostButton ? backGroundColor : textColor,
                  /* color: textColor, */
                ),
              ),
      ),
    );
  }
}
