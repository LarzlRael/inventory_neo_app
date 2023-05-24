part of '../widgets.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final List<String> genders;
  /* final List<String> genders = const ['men', 'women', 'kid'];
  final List<IconData> genderIcons = const [
    Icons.man,
    Icons.woman,
    Icons.boy,
  ]; */
  final void Function(String selectedGender) onGenderChanged;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.genders,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        emptySelectionAllowed: true,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: genders.map((size) {
          return ButtonSegment(
              /* icon: Icon(genderIcons[genders.indexOf(size)]), */
              value: size,
              label: Text(size, style: const TextStyle(fontSize: 12)));
        }).toList(),
        selected: {selectedGender},
        onSelectionChanged: (newSelection) {
          onGenderChanged(
            newSelection.first,
          );
        },
      ),
    );
  }
}
