part of 'buttons.dart';

class ExpandibleFloatingActionButton extends StatefulWidget {
  const ExpandibleFloatingActionButton({
    super.key,
    /* this.scrollController, */
  });
  /* final ScrollController? scrollController; */

  @override
  State<ExpandibleFloatingActionButton> createState() =>
      _ExpandibleFloatingActionButtonState();
}

class _ExpandibleFloatingActionButtonState
    extends State<ExpandibleFloatingActionButton> {
  bool isExpanded = false;
  bool _showIconOnly = true;
  double _buttonWidth = 50.0; // Cambia el valor según el tamaño deseado
  void _toggleButtonState() {
    setState(() {
      _showIconOnly = !_showIconOnly;
      /* _buttonWidth = _showIconOnly
          ? 50.0
          : 150.0; // Cambia los valores de tamaño según el tamaño deseado */
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 100,
      ), // Ajusta la duración de la animación según tu preferencia
      width: _buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: _toggleButtonState,
        child: _showIconOnly
            ? Center(child: Icon(Icons.favorite))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  SizedBox(width: 5),
                  Text('Me gusta'),
                ],
              ),
      ),
    );
  }
}
