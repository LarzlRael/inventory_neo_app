part of 'buttons.dart';

class FillButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  final double marginVertical;
  final double marginHorizontal;
  final bool ghostButton;
  final double borderRadius;
  final double labelButtonFontSize;
  const FillButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.labelButtonFontSize = 16.0,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.marginVertical = 5,
    this.marginHorizontal = 0,
    this.ghostButton = false,
    this.borderRadius = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: ghostButton ? backgroundColor : textColor,
      fontSize: labelButtonFontSize,
      fontWeight: FontWeight.bold,
    );
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ghostButton ? Colors.white : backgroundColor,
          side: BorderSide(
            color: backgroundColor,
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
