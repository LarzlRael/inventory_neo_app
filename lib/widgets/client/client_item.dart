part of '../widgets.dart';

class ClientItem extends StatelessWidget {
  const ClientItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'client_profile'),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNzpQcuyrPhyGRcfnvBIAnR5rdIhImb3SZydxeWy_d&s'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: 'Juancito Pinto',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        lightThemeColor: Colors.black87,
                        top: 5,
                        bottom: 5,
                      ),
                      SimpleText(
                        text: 'Zona villa exaltacion y delmas xxd',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
