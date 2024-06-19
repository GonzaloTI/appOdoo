import 'package:appeventos/screens/alumnolist.dart';
import 'package:appeventos/screens/bitacora.dart';
import 'package:appeventos/screens/home.dart';
import 'package:appeventos/screens/login.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ///* Auth Routes
    GoRoute(path: '/login', builder: (context, state) => const Login()
        // builder: (context, state) => const LoginScreen(),
        ),

    GoRoute(
      path: '/homebar',
      builder: (context, state) => Home(),
    ),
    GoRoute(
      path: '/hijoslist',
      builder: (context, state) => Clientelist(),
    ),

    GoRoute(
      path: '/bitacoralist',
      builder: (context, state) => bitacoralist(),
    ),
  ],

  ///! TODO: Bloquear si no se está autenticado de alguna manera
);
