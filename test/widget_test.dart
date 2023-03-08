// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('Counter increments smoke test', () async {
    // Build our app and trigger a frame.
    //await tester.pumpWidget(MyApp());
    print("format" + DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
    String pass = "e21A1e111";
    final validatorAngka = RegExp(".*[0-9].*");
    final validatorHurufKapital = RegExp(".*[A-Z].*");
    final validatorHurufKecil = RegExp(".*[a-z].*");

    if(pass.length >= 8 && validatorAngka.hasMatch(pass) && validatorHurufKapital.hasMatch(pass) && validatorHurufKecil.hasMatch(pass) ){
      print("valid");
    }else{
      print("gak valid");
    }
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
