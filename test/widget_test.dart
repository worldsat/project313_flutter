import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Verdant Estates App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VerdantEstatesApp());
    expect(find.text('Verdant Estates'), findsWidgets);
    expect(find.text('Explore Curated Estates'), findsOneWidget);
  });
}
