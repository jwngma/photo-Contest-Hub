import 'package:flutter/material.dart';
import 'file:///D:/flutter_projects/final_project/photo_contest_hub/photo_contest_hub/lib/screens/events/live/live_page.dart';
import 'file:///D:/flutter_projects/final_project/photo_contest_hub/photo_contest_hub/lib/screens/events/result/result_page.dart';

class AllEventsPage extends StatefulWidget {
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: TabBar(

          controller: _tabController,
          indicatorColor: Colors.yellow,
          unselectedLabelColor: Colors.white,

          labelColor: Colors.red,
          tabs: <Widget>[

            Tab(
              text: "Ongoing",
            ),
            Tab(
              text: "Result",
            ),

          ]),
      body: TabBarView(controller: _tabController, children: <Widget>[
        new LivePage(),
        ResultPage(),
      ]),
    );
  }
}
