import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/shell/presentation/app_shell.dart';
import '../../features/splash/presentation/splash_page.dart';
import '../../features/turfs/presentation/pages/turf_list_page.dart';
import '../extensions/context_x.dart';
import '../widgets/coming_soon_view.dart';

final routerProvider = Provider<GoRouter>((ref) => GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
        GoRoute(path: '/sign-in', builder: (_, __) => const SignInPage()),
        GoRoute(path: '/sign-up', builder: (_, __) => const SignUpPage()),
        StatefulShellRoute.indexedStack(
          builder: (_, __, shell) => AppShell(shell: shell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(path: '/home', builder: (_, __) => const TurfListPage()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/matches',
                builder: (c, __) =>
                    ComingSoonView(title: c.l10n!.tabMatches, icon: Icons.groups),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/chat',
                builder: (c, __) =>
                    ComingSoonView(title: c.l10n!.tabChat, icon: Icons.chat_bubble),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/profile',
                builder: (c, __) =>
                    ComingSoonView(title: c.l10n!.tabProfile, icon: Icons.person),
              ),
            ]),
          ],
        ),
      ],
    ));
