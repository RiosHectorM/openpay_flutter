import 'package:go_router/go_router.dart';
import 'package:openpay_flutter/presentation/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: ((context, state) => const HomeScreen())),
  GoRoute(
      path: '/new-client',
      builder: (context, state) => RegisterScreen(isEditing: false),
    ),
  GoRoute(
      path: '/list-clients',
      builder: (context, state) => ListClientsScreen(),
    ),
  GoRoute(
      path: '/list-markets',
      builder: (context, state) => ListMarketScreen(),
    ),
]);
