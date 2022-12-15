part of '../widgets.dart';

class CustomFileField extends StatelessWidget {
  final String name;

  const CustomFileField({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: const ['jpg', 'png', 'pdf'],
      name: name,
      /* validator: FormBuilderValidators.required(),
      decoration: const InputDecoration(
        labelText: "Subir archivo",
        hintText: "Subir archivo",
        //
        border: InputBorder.none,
      ), */
      maxFiles: 1,
      /* previewImages: true, */
      onChanged: (val) => print(val),
      selector: Row(
        children: const [
          Icon(Icons.upload_file),
          SimpleText(
            text: 'Escoger archivo',
            fontSize: 16,
          ),
        ],
      ),
      onFileLoading: (val) {
        print(val);
      },
    );
  }
}
