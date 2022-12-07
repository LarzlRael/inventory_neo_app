part of 'delegates.dart';

class ClientsDelegate extends SearchDelegate {
  final clientsService = ClientsServices();
  @override
  final String searchFieldLabel;

  ClientsDelegate() : searchFieldLabel = 'Buscar cliente por nombre';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    /* TODO return something */
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: clientsService.getClientsWithParameters(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ClientModel>> snapshot) {
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
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: clientsService.getClients(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ClientModel>> snapshot) {
        if (!snapshot.hasData) {
          return simpleLoading();
        }
        final clients = snapshot.data;
        return ListView.builder(
          itemCount: clients?.length,
          itemBuilder: (BuildContext context, int index) {
            return ClientItem(
              clientModel: clients![index],
            );
          },
        );
      },
    );
  }

  /* ListView listViewItems(List<ShopModel> suggestionList) {
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, i) {
        return renderItemList(context, suggestionList[i], true);
      },
    );
  }

  ListView listViewBlocHistory(List<HistoryModel> suggestionList) {
    final pinterHistory = suggestionList
        .map((e) => shopData.firstWhere(((shopData) {
              if (shopData.shopName == (e.querySearched)) {
                shopData.id = e.id;
              }
              return shopData.shopName == (e.querySearched);
            })))
        .toList();

    return ListView.builder(
      itemCount: pinterHistory.length,
      itemBuilder: (context, i) {
        return renderItemList(context, pinterHistory[i], false);
      },
    );
  }

  Widget renderItemList(
      BuildContext context, ShopModel suggestionItem, bool registerHistory) {
    final double sizeImage = 40;
    if (!registerHistory) {
      return ListTile(
          leading: const Icon(Icons.history),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(suggestionItem.imageAsset,
                width: sizeImage, height: sizeImage),
          ),
          title: Text(suggestionItem.shopName.toTitleCase()),
          onLongPress: () => showAlertDialog(
                  context,
                  "Eliminar de historial",
                  SimpleText(
                      text:
                          "¿Desea eliminar ${suggestionItem.shopName.toTitleCase()} de su historial?"),
                  () async {
                await historyBloc.deleteHistoryById(suggestionItem.id!);
                historyBloc.getAllHistory();
              }),
          onTap: () => launchURL(suggestionItem.goToUrl));
    }
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(suggestionItem.imageAsset,
            width: sizeImage, height: sizeImage),
      ),
      title: Text(suggestionItem.shopName.toTitleCase()),
      onTap: () {
        launchURL(suggestionItem.goToUrl);
        if (registerHistory) {
          historyBloc
              .newHistory(HistoryModel(querySearched: suggestionItem.shopName));
        }
      },
    );
  }
*/
}
