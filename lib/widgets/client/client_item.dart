part of '../widgets.dart';

class ClientItem extends StatelessWidget {
  final ClientModel clientModel;
  final Function? onTap;
  final Widget? trailing;
  const ClientItem({
    super.key,
    required this.clientModel,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else {
            context.push(
              '/client_profile',
              extra: clientModel,
            );
          }
        },
        leading: CircleAvatar(
          radius: 20,
          child: SimpleText(
            text:
                '${clientModel.firstName[0].toUpperCase()}${clientModel.lastName[0].toUpperCase()}',
            fontSize: 17,
            lightThemeColor: Colors.white,
          ),
        ),
        title: SimpleText(
          text:
              '${clientModel.firstName} ${clientModel.lastName}'.toTitleCase(),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          lightThemeColor: Colors.black87,
          top: 5,
          bottom: 5,
        ),
        subtitle: SimpleText(
          text: clientModel.address1.toCapitalize(),
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
