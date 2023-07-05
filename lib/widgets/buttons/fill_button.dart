part of 'buttons.dart';

class FillButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color textColor;

  final double marginVertical;
  final double marginHorizontal;
  final bool ghostButton;
  final double borderRadius;
  final double labelButtonFontSize;
  final FontWeight? fontWeight;
  const FillButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.fontWeight,
    this.labelButtonFontSize = 16.0,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
    this.ghostButton = false,
    this.borderRadius = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      color: ghostButton ? backgroundColor : textColor,
      fontSize: labelButtonFontSize,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.primary,
          side: BorderSide(
            color: backgroundColor ?? colorScheme.primary,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 40.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
