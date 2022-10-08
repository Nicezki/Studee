import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyHome());

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
        '/secondpage': (context) => SecondPage(),
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
        title: const Text('Flutter Demo'),
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
              Navigator.pushNamed(context, '/secondpage');
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

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(child: Text('หน้าที่2')),
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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: 888Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '888Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[800],
        unselectedItemColor: Colors.teal[200],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Categories extends StatefulWidget {
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
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Text(
        categories[index],
      ),
    );
  }
}

/*
Class TabBarDemo extend StatelessWidget {
  const TabBarDemo({Key? key} : super(key: key));
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom:const TabBar(tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_train)),
              Tab(icon: Icon(Icons.directions_bike)),
            ]),
            title: const Text('Tab Demo'),
          ),
          body: const
        )
      )
    )
  }
}*/