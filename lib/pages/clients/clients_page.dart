part of '../pages.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar cliente',
        onPressed: () {
          Navigator.pushNamed(context, 'client_register_page');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        showTitle: true,
        title: 'Clientes',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(
                context: context,
                delegate: ItemsInventoryDelegate(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ClientItem(),
            ClientItem(),
            ClientItem(),
          ],
        ),
      ),
    );
  }
}
