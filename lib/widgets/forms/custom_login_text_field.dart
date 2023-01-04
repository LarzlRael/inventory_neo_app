part of '../widgets.dart';

class CustomLoginTextField extends StatefulWidget {
  final String name;
  final IconData icon;
  final String placeholder;
  final bool passwordField;
  final TextInputType keyboardType;
  const CustomLoginTextField({
    Key? key,
    required this.name,
    required this.icon,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.passwordField = false,
  }) : super(key: key);

  @override
  State<CustomLoginTextField> createState() =>
      _CustomFormBuilderTextFieldState();
}

class _CustomFormBuilderTextFieldState extends State<CustomLoginTextField> {
  bool _obscureText = true;
  /* bool showPassword = false; */
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: FormBuilderTextField(
          keyboardType: widget.keyboardType,
          obscureText: widget.passwordField && _obscureText,
          name: widget.name,
          /* validator: FormBuilderValidators.required(), */
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: widget.placeholder,
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
            suffixIcon: widget.passwordField
                ? IconButton(
                    icon: _obscureText
                        ? const Icon(Icons.link_off_sharp)
                        : const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            prefixIcon: Icon(widget.icon),
          ),
        ),
      ),
    );
  }
}
