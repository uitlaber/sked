import 'package:get/get.dart';
import 'package:sked/controllers/bindings/app_binding.dart';
import 'package:sked/controllers/bindings/archive_binding.dart';
import 'package:sked/controllers/bindings/sked_binding.dart';
import 'package:sked/screens/archive.dart';
import 'package:sked/screens/create_sked.dart';
import 'package:sked/screens/home.dart';
import 'package:sked/screens/settings.dart';
import 'package:sked/screens/sked.dart';
import 'package:sked/screens/splash.dart';

abstract class Routes {
  // Main Menu Route
  static const String homeRoute = '/';
  static const String splashRoute = '/splash';
  static const String sked = '/sked/:id';
  static const String createSked = '/create-sked';
  static const String archiveSked = '/archive-sked';
  static const String settings = '/settings';
}

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.splashRoute,
        page: () => const Splash(),
        transition: Transition.noTransition,
        binding: AppBinding()),

    //Главная
    GetPage(
        name: Routes.homeRoute,
        page: () => const Home(),
        transition: Transition.noTransition,
        binding: AppBinding()),

    //Опись
    GetPage(
        name: Routes.sked,
        page: () => Sked(),
        transition: Transition.noTransition,
        binding: SkedBinding()),

    //Новая опись
    GetPage(
        name: Routes.createSked,
        page: () => CreateSked(),
        transition: Transition.noTransition,
        binding: SkedBinding()),

    //Архив
    GetPage(
        name: Routes.archiveSked,
        page: () => Archive(),
        transition: Transition.noTransition,
        binding: ArchiveBinding()),

    //Настройки
    GetPage(
        name: Routes.settings,
        page: () => const Settings(),
        transition: Transition.noTransition,
        binding: AppBinding()),
  ];
}
