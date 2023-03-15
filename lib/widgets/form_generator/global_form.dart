part of '../widgets.dart';

class GlobalForm extends StatelessWidget {
  final List<FormModel> form;
  final Function onSubmiting;
  final formKey = GlobalKey<FormBuilderState>();

  GlobalForm({super.key, required this.form, required this.onSubmiting});

  Map<String, dynamic> generateInitialValues() {
    Map<String, dynamic> initialValues = {};
    for (var i in form) {
      initialValues = {
        ...initialValues,
        i.name: i.value,
      };
    }
    return initialValues;
  }

  onSubmit(GlobalKey<FormBuilderState> formKey) {
    formKey.currentState!.save();
    onSubmiting(formKey.currentState!.value);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      initialValue: generateInitialValues(),
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          ...form.map((e) {
            switch (e.type) {
              case 'input':
                return Input(
                  formModel: e,
                );

              default:
                return Text('xd');
            }
          }),
          ElevatedButton(
            onPressed: () {
              onSubmit(formKey);
            },
            child: const Text('Submit xd'),
          ),
        ],
      ),
    );
  }
}
