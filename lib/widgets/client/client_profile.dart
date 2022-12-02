part of '../widgets.dart';

class ClientProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              color: Colors.deepPurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNzpQcuyrPhyGRcfnvBIAnR5rdIhImb3SZydxeWy_d&s'),
                  ),
                  SimpleText(
                    text: 'Nombre del cliente',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    top: 10,
                    bottom: 5,
                    lightThemeColor: Colors.white,
                  ),
                ],
              ),
            ),
            _tabSection(context),
          ],
        ),
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
              labelColor: Colors.deepPurple,
              tabs: [
                Tab(text: "Home"),
                Tab(text: "Articles"),
                Tab(text: "User"),
              ],
            ),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              Container(
                child: Text("Home Body"),
              ),
              Container(
                child: Text("Articles Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
