import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Verdant Estates App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VerdantEstatesApp());
    expect(find.text('VERDANT ESTATES'), findsWidgets);
    expect(find.text('Explore Estates'), findsOneWidget);
  });
}
