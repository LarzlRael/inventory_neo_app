part of '../widgets.dart';

Future<void> showMyDialogTagMaterial(
  BuildContext context,
  int tagId,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final categoriesMaterialProviders =
          context.read<CategoriesMaterialProviders>();
      final textTheme = Theme.of(context).textTheme;
      return FutureBuilder(
        future: categoriesMaterialProviders.getTagById(tagId),
        builder: (_, AsyncSnapshot<TagModel> snapshot) {
          if (!snapshot.hasData) {
            return simpleLoading(
              color: Colors.white,
              strokeWith: 2,
            );
          }
          final tag = snapshot.data!;
          return AlertDialog(
            title: Text(
              tag.name.toCapitalize(),
              style: textTheme.titleSmall!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            content: tag.description.isEmpty
                ? null
                : SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Text(
                          tag.description.toCapitalize(),
                        ),
                      ],
                    ),
                  ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

void asyncShowConfirmDialog(
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
            context.pop();
            await onAccept!();
            /* GlobalSnackBar.show(context, 'Comentario eliminado'); */
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void showConfirmDialog(
  BuildContext context,
  String title,
  String description,
  Function() onAccept,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
            onAccept();
            /* GlobalSnackBar.show(context, 'Comentario eliminado'); */
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

showOfferDialog(
  /* OneHomeworkBloc blocHomework,
    Homework homework,
    UserModel userModel, */
  BuildContext context,
  bool verify,
) {
  showDialog(
    context: context,
    builder: (context) {
      bool isLoading = false;
      final formKey = GlobalKey<FormState>();
      int emailField = 0;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: SimpleText(
              text: !verify ? "Hacer oferta" : "Editar oferta",
              fontSize: 24.0,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            content: SizedBox(
              height: 300,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /* const Text(
                          "Ingrese cantidad ",
                        ), */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*  SimpleText(
                                text:
                                    "Puntos requeridos: ${homework.offeredAmount}",
                                fontSize: 12,
                                bottom: 5,
                              ), */
                            /* SimpleText(
                                text:
                                    "Puntos disponibles: ${userModel.wallet.balanceTotal}",
                                fontSize: 12,
                              ), */
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilder(
                        key: formKey,
                        child: Column(
                          children: const [
                            /* CustomTextField(
                              label: 'Nombre',
                              name: 'firstname',
                            ),
                            CustomTextField(
                              label: 'Apellidos',
                              name: 'firstname',
                            ), */
                            CustomFileField(
                              name: 'file',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: !isLoading ? () async {} : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          // fixedSize: Size(250, 50),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                !verify ? "Ofertar" : "Editar oferta",
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
