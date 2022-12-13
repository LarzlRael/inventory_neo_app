part of '../widgets.dart';

Future<void> showMyDialogTagMaterial(BuildContext context, String tagId) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      final tagServices = TagsServices();
      return FutureBuilder(
        future: tagServices.getTagById(tagId),
        builder: (BuildContext context, AsyncSnapshot<TagsModel> snapshot) {
          if (!snapshot.hasData) {
            return simpleLoading();
          }
          final tag = snapshot.data!;
          return AlertDialog(
            title: SimpleText(
              text: tag.name,
              textAlign: TextAlign.center,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const ClipRRect(
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
                    text: tag.description,
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
    },
  );
}

void showConfirmDialog(
  BuildContext context,
  String title,
  String description,
  Future<dynamic> Function()? onAccept,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'OK');
            await onAccept!();
            /* GlobalSnackBar.show(context, 'Comentario eliminado'); */
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
