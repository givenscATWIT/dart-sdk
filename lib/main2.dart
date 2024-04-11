import 'package:workouttutorial/models/workout_data.dart';
import 'pages/home_page.dart';

void main() async{
  // initalize hive
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox("workout_database1");

  runApp(const myApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ), // MaterialApp
    ); // ChangeNotifierProvider
  }
}