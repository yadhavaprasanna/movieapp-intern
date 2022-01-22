import 'package:flutter/material.dart';
import 'package:movie/widgets/gird3.dart';
import 'package:movie/widgets/grid1.dart';
import 'package:movie/widgets/grid2.dart';



//94129e99473cda1e44116ac3b1f16c6a
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        title: Text("Book Movie"),
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.green,
          tabs: [
            Tab(
              text: 'POPULAR',
            ),
            Tab(
              text: 'TOP-RATED',
            ),
            Tab(text: 'UPCOMING'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [Grid1(), Grid2(), Grid3()],
      ),
    );
  }
}
