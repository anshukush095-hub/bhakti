import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bhakti_app/main.dart';
import 'package:bhakti_app/providers/app_state.dart';

void main() {
  testWidgets('Puja Vidhi smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const PujaVidhiApp(),
      ),
    );

    // Verify splash screen elements
    expect(find.text('Puja Vidhi'), findsOneWidget);
    expect(find.text('शुरू करें'), findsOneWidget);
  });
}
