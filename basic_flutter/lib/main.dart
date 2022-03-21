import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.onClicked}) : super(key: key);
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Employee App",
      home: const MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.blue.shade900,
        splashColor: Colors.blue,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Raleway-Bold',
                fontSize: 20,
                color: Colors.black,
              ),
            ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<String> dummyemployees;

  @override
  void initState() {
    super.initState();
    dummyemployees = [];
    addDummyEmployees();
  }

  addDummyEmployees() {
    dummyemployees.add("Employee 1");
    dummyemployees.add("Employee 2");
    dummyemployees.add("Employee 3");
  }

  removeDummyEmployee(index) {
    setState(() {
      dummyemployees.removeAt(index);
    });
  }

  Widget swipeDeleteButton() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  undoDelete(index, dummyemployee) {
    setState(() {
      dummyemployees.insert(index, dummyemployee);
    });
  }

  showSnackBar(context, dummyemployee, index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$dummyemployee deleted'),
        action: SnackBarAction(
            label: "undo delete",
            onPressed: () {
              undoDelete(index, dummyemployee);
            }),
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: dummyemployees.length,
      itemBuilder: (BuildContext context, int index) {
        return row(context, index);
      },
    );
  }

  Widget row(context, index) {
    return Dismissible(
      key: Key(dummyemployees[index]),
      onDismissed: (direction) {
        var dummyemployee = dummyemployees[index];
        showSnackBar(context, dummyemployee, index);
        removeDummyEmployee(index);
      },
      background: swipeDeleteButton(),
      child: Card(
        child: ListTile(
          title: Text(dummyemployees[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final icon = isDarkMode ? Icons.light_mode : Icons.dark_mode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee App'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: [
          ThemeSwitcher(
            builder: (context) => IconButton(
              icon: Icon(icon),
              onPressed: () {
                final theme =
                    isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
                final switcher = ThemeSwitcher.of(context);
                switcher.changeTheme(theme: theme);
              },
            ),
          ),
        ],
      ),
      body: list(),
    );
  }
}
