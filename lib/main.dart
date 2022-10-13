import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studee/view_subject.dart';
import 'package:studee/register.dart';
import 'package:studee/login.dart';

int? cur_page;

class User {
  final String? id;
  final String? name;
  final String? date_time;
  final String? location;
  const User({
    this.id,
    this.name,
    this.date_time,
    this.location,
  });
}

class UserProvider with ChangeNotifier {
  List<User> _nuser = [];
  //Map<String, dynamic> _user = {};

  List<User> get users {
    return _nuser;
  }

  // Map<String, dynamic> get users {
  //   return _user;
  // }

  addNewUser(User data) {
    _nuser.add(data);
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  final appTitle = 'Example Form';

  const MyHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(title: appTitle),
        '/LoginPage': (context) => LoginPage(),
        '/RegisterPage': (context) => RegisterPage(),
        '/add_SecondPage': (context) => add_SecondPage(),
        '/add_SecondPage2': (context) => add_SecondPage2(),
        '/add_SecondPage3': (context) => add_SecondPage3(),
        '/view_subject': (context) => SubjectDetail('00123456'),
      },
      //home: MyApp(title: appTitle),
    );
  }
}

class MyApp extends StatelessWidget {
  final String title;
  const MyApp({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
      appBar: AppBar(
        title: const Text('Studee'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    cur_page == 0
                        ? "/add_SecondPage"
                        : cur_page == 1
                            ? "/add_SecondPage2"
                            : cur_page == 2
                                ? "/add_SecondPage3"
                                : "/");
              })
        ],
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //  DrawerHeader(
          //   child: Column(
          //    children: const [
          //      CircleAvatar(
          //       child: Icon(Icons.person),
          //     ),
          //     Text('Drawer  Header'),
          //   ],
          // ),
          // decoration: BoxDecoration(color: Colors.blue),
          //),
          UserAccountsDrawerHeader(
            accountName: const Text('Thanapol Kaenjan'),
            accountEmail: const Text('1163104004424@mail.rmutt.ac.th'),
            currentAccountPicture: CircleAvatar(
              child: FlutterLogo(
                size: 42,
              ),
              backgroundColor: Colors.white,
            ),
            otherAccountsPictures: [
              const CircleAvatar(
                child: Text('P'),
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
              ),
              CircleAvatar(
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
              ),
            ],
          ),

          ListTile(
            leading: Icon(Icons.access_alarm),
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pushNamed(context, '/LoginPage');
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {},
          ),
        ],
      )),
    );
  }
}

class add_SecondPage extends StatelessWidget {
  const add_SecondPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add time-table'),
      ),
      body: Center(child: Text('Add time-table here')),
    );
  }
}

class add_SecondPage2 extends StatelessWidget {
  const add_SecondPage2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
      ),
      body: Center(child: Text('Add note here')),
    );
  }
}

class add_SecondPage3 extends StatelessWidget {
  const add_SecondPage3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task'),
      ),
      body: Center(child: Text('Add task here')),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyStatelessWidget(),
    MyStatelessWidget2(),
    MyStatelessWidget3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      cur_page = index;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Time-Table',
            // activeIcon: TabBarDemo(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Task',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.teal[200],
        onTap: _onItemTapped,
      ),
    );
  }
}

const List<Tab> tabs = <Tab>[
  Tab(
    text: 'Mon',
  ),
  Tab(text: 'Tue'),
  Tab(text: 'Wed'),
  Tab(
    text: 'Thu',
  ),
  Tab(text: 'Fri'),
  Tab(text: 'Sat'),
  Tab(text: 'Sun'),
];

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: const TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return Column(
                children: [
                  Container(),
                  SizedBox(height: 6),
                  Container(),
                  Container(
                    height: 900,
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 10),
                            child: Row(children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(209, 189, 189, 189),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://www.techhub.in.th/wp-content/uploads/2021/05/577280151-1.jpg'))),
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color:
                                          Color.fromARGB(209, 189, 189, 189)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Text("tee888 Go Go Go"),
                                        Text(
                                            "Good game, pays hard, pays quickly."),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("B:50"),
                                            Text("A:99"),
                                            Text("money:9999"),
                                            IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/view_subject');
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          );
                        }),
                  )
                ],
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}

class MyStatelessWidget2 extends StatelessWidget {
  const MyStatelessWidget2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return Column(
                children: [
                  Container(),
                  SizedBox(height: 6),
                  Container(),
                  Container(
                    height: 900,
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 10),
                            child: Row(children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(209, 189, 189, 189),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWHW53Mm8mM9h4flyCwCm4gar1WgnTPnjMSrOWp1DsmYrs6olw5KulNo1ZZS1D8kV-fpo&usqp=CAU'))),
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color:
                                          Color.fromARGB(209, 189, 189, 189)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Text("tee888 Go Go Go"),
                                        Text(
                                            "Good game, pays hard, pays quickly."),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("B:50"),
                                            Text("A:99"),
                                            Text("money:9999"),
                                            IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/view_subject');
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          );
                        }),
                  )
                ],
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}

class MyStatelessWidget3 extends StatelessWidget {
  const MyStatelessWidget3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return Column(
                children: [
                  Container(),
                  SizedBox(height: 6),
                  Container(),
                  Container(
                    height: 900,
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 10),
                            child: Row(children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(209, 189, 189, 189),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://i.pinimg.com/736x/bb/e7/4f/bbe74f25d8ad8e3dcc130d8548151275.jpg'))),
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color:
                                          Color.fromARGB(209, 189, 189, 189)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Text("tee888 Go Go Go"),
                                        Text(
                                            "Good game, pays hard, pays quickly."),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("B:50"),
                                            Text("A:99"),
                                            Text("money:9999"),
                                            IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/view_subject');
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          );
                        }),
                  )
                ],
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}

/*
class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  int SelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ));
  }

  Widget buildCategory(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        categories[index],
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(220, 29, 29, 29)),
      ),
    );
  }
}
*/

/*
class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_train)),
              Tab(icon: Icon(Icons.directions_bike)),
            ]),
            title: const Text('Tab Demo'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_train),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
*/