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
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          Navigator.pushNamed(
            context,
            'client_profile',
            arguments: clientModel,
          );
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 70,
                  child: SimpleText(
                    text:
                        '${clientModel.firstName[0].toUpperCase()}${clientModel.lastName[0].toUpperCase()}',
                    fontSize: 17,
                    lightThemeColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: '${clientModel.firstName} ${clientModel.lastName}'
                            .toTitleCase(),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        lightThemeColor: Colors.black87,
                        top: 5,
                        bottom: 5,
                      ),
                      SimpleText(
                        text: clientModel.billing.address1.toCapitalize(),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
