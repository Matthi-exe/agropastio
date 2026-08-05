import 'package:flutter_test/flutter_test.dart';

import 'package:agropastio/main.dart';

void main() {
  testWidgets('Aurora app launches to landing screen', (tester) async {
    await tester.pumpWidget(const AuroraApp());

    expect(find.text('Aurora'), findsOneWidget);
    expect(find.text('SE CONNECTER'), findsOneWidget);
    expect(find.text('PASSER EN MODE HORS-LIGNE'), findsOneWidget);
  });
}
