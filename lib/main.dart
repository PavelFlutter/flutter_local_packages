import 'package:flutter/material.dart';
import 'package:package_example/user_storage.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:cloud_messaging_service/cloud_messaging_service.dart;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const secureStorage = SecureStorage();
  const userStorage = UserStorage(storage: secureStorage);
  final cloudMessagingService = CloudMessagingService();


  runApp(
    MyApp(userStorage: userStorage),
  );
}

class MyApp extends StatelessWidget {
  final UserStorage userStorage;

  MyApp({required this.userStorage, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        userStorage: userStorage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserStorage userStorage;
  final String title;

  MyHomePage({required this.userStorage, super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = '';
  TextEditingController controller = TextEditingController();

  void _showUserName() async {
    String _userName = await widget.userStorage.fetchUserName();

    setState(() {
      userName = _userName;
    });
  }

  _setUserName() async {
    String name = controller.text;
    await widget.userStorage.setUserName(name: name);
    String _userName = await widget.userStorage.fetchUserName();

    setState(() {
      userName = _userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello, $userName!',
            ),
            TextFormField(
              controller: controller,
            ),
            TextButton(
              onPressed: _setUserName,
              child: const Text('set user'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showUserName,
        tooltip: 'show user',
        child: const Icon(Icons.remove_red_eye_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
