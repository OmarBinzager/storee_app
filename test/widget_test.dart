import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storee/app/app.dart';
import 'package:storee/app/service_locator.dart';
import 'package:storee/core/database/app_database.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'onboarding_completed': true});
    final prefs = await SharedPreferences.getInstance();
    await sl.reset();
    await initServiceLocator(
      database: AppDatabase.inMemory(),
      preferences: prefs,
    );
  });

  testWidgets('StoreeApp launches successfully with Arabic navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const StoreeApp());
    // Splash screen has a delay and animation
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Verify main branding and tabs are rendered
    expect(find.text('ستوري'), findsWidgets);
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('الطلبات'), findsOneWidget);
    expect(find.text('العميلات'), findsOneWidget);
    expect(find.text('الخزنات'), findsOneWidget);
    expect(find.text('التقارير'), findsOneWidget);
  });
}
