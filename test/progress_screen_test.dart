import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kegel_egzersiz_app/core/localization/gen/app_localizations.dart';
import 'package:kegel_egzersiz_app/core/providers/core_providers.dart';
import 'package:kegel_egzersiz_app/features/progress/presentation/progress_screen.dart';

void main() {
  // Regression: the summary cards used Row(crossAxisAlignment: stretch) inside
  // the vertically-unbounded ListView, which threw "BoxConstraints forces an
  // infinite height" during layout — a paint-phase failure that silently
  // blanked the whole Progress body on device. The fix wraps the Row in an
  // IntrinsicHeight. The Row is built regardless of provider state, so we can
  // exercise the layout without a live database: overriding databaseProvider to
  // throw keeps every provider in an error state (the screen falls back to its
  // `?? default` values) and, crucially, creates no Drift watch streams — so
  // there are no stream-close timers to fight at teardown.
  testWidgets('ProgressScreen summary row lays out without an infinite-height '
      'exception', (tester) async {
    tester.view.physicalSize = const Size(1170, 2532); // iPhone-ish
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWith(
            (ref) => throw UnimplementedError('no database in this layout test'),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('tr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ProgressScreen(),
        ),
      ),
    );
    await tester.pump();

    // Before the fix, laying out the summary Row threw "BoxConstraints forces
    // an infinite height", which cascaded into "hasSize" failures and aborted
    // the whole SliverList — blanking the body. We assert that signature is
    // gone. (The all-error fallback used here also surfaces a harmless ~44px
    // chart-placeholder overflow that never occurs with real data, so we check
    // for the infinite-height/hasSize regression specifically rather than for
    // the absence of any exception.)
    final error = tester.takeException()?.toString() ?? '';
    expect(error.contains('infinite height') || error.contains('hasSize'),
        isFalse,
        reason: 'summary Row must lay out without forcing an infinite height');

    // The fix wraps the summary Row in an IntrinsicHeight, and the body paints.
    expect(find.byType(IntrinsicHeight), findsWidgets);
    expect(find.byType(Card), findsWidgets);
  });
}
