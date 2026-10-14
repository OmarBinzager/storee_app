import 'package:go_router/go_router.dart';
import '../presentation/main_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'main',
      builder: (context, state) => const MainScaffold(),
    ),
  ],
);
