part of '../widgets.dart';

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: SimpleText(
          text: 'Plata 950',
          textAlign: TextAlign.center,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Image(
                  image: NetworkImage(
                      'https://i1.wp.com/edgartica.com/wp-content/uploads/2019/11/73040527_10156222877376330_4430677903092482048_o-1-e1573360227974.jpg?fit=300%2C300&ssl=1'),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SimpleText(
                text:
                    'Para la plata, un objeto que lleva el distintivo de Plata 950 se refiere a una determinada pieza que cuenta con un 95% de material que es plata y un 5% que se corresponde con otro material, generalmente cobre.',
                top: 10,
                lineHeight: 1.3,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
