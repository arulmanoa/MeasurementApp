import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:first_app/calculation.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
  }

  testWidgets('measurement calculation smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(CalculationPage()));
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, '30');
    expect(find.text('30'), findsOneWidget);

     final drop = find.byType(DropdownButton);
       // First, tap the dropdown button.
       await tester.tap(drop);
       await tester.tap(find.text('Height'));
      //  expect(await tester.gett(find.text('Car')), isNotNull);

  });
}
