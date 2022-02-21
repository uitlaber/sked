import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sked/controllers/bindings/app_binding.dart';
import 'package:sked/routes.dart';
import 'package:sked/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: const Home(),
      initialRoute: Routes.homeRoute,
      initialBinding: AppBinding(),
      getPages: AppPages.routes
    );
  }


}

void initServices() async {
  if (kDebugMode) {
    print('starting services ...');
  }

  if (kDebugMode) {
    print('All services started...');
  }
}


