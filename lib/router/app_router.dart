import 'package:go_router/go_router.dart';
import 'package:openpay_flutter/presentation/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: ((context, state) => const HomeScreen()))
]);
