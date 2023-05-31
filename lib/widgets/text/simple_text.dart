part of '../widgets.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? lightThemeColor;
  final Color? darkThemeColor;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  final TextAlign? textAlign;
  final double? lineHeight;
  final bool setUniqueColor;
  const SimpleText({
    Key? key,
    required this.text,
    this.fontWeight,
    this.padding,
    this.fontSize,
    this.style,
    this.textAlign,
    this.lineHeight,
    this.lightThemeColor,
    this.darkThemeColor,
    this.setUniqueColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeStatus = false;
    /* final themeStatus = Provider.of<ThemeChanger>(context, listen: true); */
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        style: style ??
            TextStyle(
              height: lineHeight,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontSize: fontSize ?? 14,
              /* color: color ?? Colors.black, */
              /*  color: color != null
                  ? isDarkMode
                      ? Colors.black
                      : Colors.white
                  : color, */
              /* color: isDarkMode
                  ? darkThemeColor ?? Colors.white
                  : color ?? Colors.black, */
              color: setUniqueColor
                  ? lightThemeColor
                  : themeStatus
                      ? darkThemeColor ?? Colors.white
                      : lightThemeColor ?? Colors.black,
            ),
      ),
    );
  }
}
