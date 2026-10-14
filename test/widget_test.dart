import 'package:flutter_test/flutter_test.dart';
import 'package:storee/app/app.dart';
import 'package:storee/app/service_locator.dart';
import 'package:storee/core/database/app_database.dart';

void main() {
  setUp(() async {
    await sl.reset();
    await initServiceLocator(database: AppDatabase.inMemory());
  });

  testWidgets('StoreeApp launches successfully with Arabic navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const StoreeApp());
    await tester.pumpAndSettle();

    // Verify main branding and tabs are rendered
    expect(find.text('ستوري'), findsOneWidget);
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('الطلبات'), findsOneWidget);
    expect(find.text('العميلات'), findsOneWidget);
    expect(find.text('الخزنات'), findsOneWidget);
    expect(find.text('التقارير'), findsOneWidget);
  });
}
