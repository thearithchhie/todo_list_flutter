import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'bindings/root_binding.dart';
import 'common/constants/app_color.dart';
import 'views/add_todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.DEFAULT_COLOR),
        useMaterial3: false,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white12,
        ),
      ),
      initialBinding: RootBinding(),
      debugShowCheckedModeBanner: false,
      home: const AddTodoList(),
    );
  }
}
