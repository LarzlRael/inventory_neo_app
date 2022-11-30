part of '../../pages.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CardItemInventory(),
          CardItemInventory(),
          CardItemInventory(),
        ],
      ),
    );
  }
}
