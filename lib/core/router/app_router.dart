import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/achievements/presentation/achievements_screen.dart';
import '../../features/exercise_session/presentation/session_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/history/presentation/session_detail_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/home_shell.dart';
import '../../features/onboarding/application/onboarding_providers.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/program/presentation/program_screen.dart';
import '../../features/program/presentation/week_detail_screen.dart';
import '../../features/program_editor/presentation/program_detail_editor_screen.dart';
import '../../features/program_editor/presentation/program_list_editor_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/settings/presentation/how_to_use_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../providers/core_providers.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// App router. Exposed as a provider so it can be wired to notification taps.
final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final completed = ref.read(onboardingCompletedProvider);
      final atOnboarding = state.matchedLocation == '/onboarding';
      if (!completed && !atOnboarding) return '/onboarding';
      if (completed && atOnboarding) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: _rootKey,
        builder: (c, s) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/program',
              builder: (c, s) => const ProgramScreen(),
              routes: [
                GoRoute(
                  path: 'week/:weekId',
                  builder: (c, s) => WeekDetailScreen(
                    weekId: int.parse(s.pathParameters['weekId']!),
                  ),
                ),
                GoRoute(
                  path: 'editor',
                  builder: (c, s) => const ProgramListEditorScreen(),
                  routes: [
                    GoRoute(
                      path: ':programId',
                      builder: (c, s) => ProgramDetailEditorScreen(
                        programId: int.parse(s.pathParameters['programId']!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/progress', builder: (c, s) => const ProgressScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/history',
              builder: (c, s) => const HistoryScreen(),
              routes: [
                GoRoute(
                  path: 'day/:date',
                  builder: (c, s) => SessionDetailScreen(
                    date: DateTime.parse(s.pathParameters['date']!),
                  ),
                ),
              ],
            ),
          ]),
        ],
      ),
      // Full-screen routes pushed over the shell.
      GoRoute(
        path: '/session/:exerciseId',
        parentNavigatorKey: _rootKey,
        builder: (c, s) => SessionScreen(
          exerciseId: int.parse(s.pathParameters['exerciseId']!),
        ),
      ),
      GoRoute(
        path: '/achievements',
        parentNavigatorKey: _rootKey,
        builder: (c, s) => const AchievementsScreen(),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootKey,
        builder: (c, s) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'guide',
            builder: (c, s) => const HowToUseScreen(),
          ),
        ],
      ),
    ],
  );

  // A notification tap deep-links by pushing its payload route.
  ref.read(notificationServiceProvider).onSelectRoute = router.go;

  return router;
});
