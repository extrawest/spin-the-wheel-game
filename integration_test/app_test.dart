import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:spin_wheel_game/main.dart' as app;
import 'package:spin_wheel_game/widgets/prize_dialog.dart';
import 'package:spin_wheel_game/widgets/spin_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  defineIntegrationTest();
}

void defineIntegrationTest() {
  testWidgets('app launch', (tester) async {
    app.main();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    
    expect(find.byType(SpinButton), findsOneWidget);

    await tester.tap(find.byType(SpinButton));
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey(okButtonKey)));
  });
}