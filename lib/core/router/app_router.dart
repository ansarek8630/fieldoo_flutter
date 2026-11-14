import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/booking/presentation/pages/booking_page.dart';
import '../../features/chat/presentation/pages/chat_list_page.dart';
import '../../features/chat/presentation/pages/chat_room_page.dart';
import '../../features/matches/presentation/pages/matches_page.dart';
import '../../features/shell/presentation/app_shell.dart';
import '../../features/splash/presentation/splash_page.dart';
import '../../features/turfs/presentation/pages/turf_details_page.dart';
import '../../features/turfs/presentation/pages/turf_list_page.dart';
import '../extensions/context_x.dart';
import '../widgets/coming_soon_view.dart';

final routerProvider = Provider<GoRouter>((ref) => GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
        GoRoute(path: '/sign-in', builder: (_, __) => const SignInPage()),
        GoRoute(path: '/sign-up', builder: (_, __) => const SignUpPage()),
        GoRoute(
          path: '/turfs/:id',
          builder: (_, state) => TurfDetailsPage(turfId: state.pathParameters['id']!),
          routes: [
            GoRoute(
              path: 'book',
              builder: (_, state) => BookingPage(turfId: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: '/chats/:id',
          builder: (_, state) => ChatRoomPage(roomId: state.pathParameters['id']!),
        ),
        StatefulShellRoute.indexedStack(
          builder: (_, __, shell) => AppShell(shell: shell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(path: '/home', builder: (_, __) => const TurfListPage()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: '/matches', builder: (_, __) => const MatchesPage()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: '/chat', builder: (_, __) => const ChatListPage()),
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
