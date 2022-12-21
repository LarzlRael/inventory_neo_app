part of '../pages.dart';

class ClientsPageSelectable extends StatelessWidget {
  const ClientsPageSelectable({super.key});

  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider = Provider.of<CardInventoryProvider>(context);

    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        showTitle: true,
        title: 'Seleccionar cliente',
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: getClients(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ClientModel>> snapshot) {
                if (!snapshot.hasData) {
                  return simpleLoading();
                }
                final clients = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: clients?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClientItem(
                        clientModel: clients![index],
                        onTap: () {
                          cardInventoryProvider.setClient = clients[index];
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
