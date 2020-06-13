import 'package:flutter_test/flutter_test.dart';

import 'components/counter/counter.controller.dart';
import 'components/dummy/dummy.controller.dart';
import 'components/sync-test/index.dart';
import 'utility.dart';
import 'widgets/blank_widget.dart';
import 'widgets/error_widget6.dart';
import 'widgets/error_widget7.dart';
import 'widgets/reset_all.dart';

void main() {
  testWidgets('null controller specified in momentum', (tester) async {
    var widget = errorWidget6();
    await inject(tester, widget);
    expect(tester.takeException(), isInstanceOf<Exception>());
  });

  testWidgets('null controllers and services', (tester) async {
    var widget = blankWidget();
    await inject(tester, widget);
    var blankText = find.text('Blank App');
    expect(blankText, findsOneWidget);
  });

  testWidgets('duplicate controller', (tester) async {
    var widget = errorWidget7();
    await inject(tester, widget);
    expect(tester.takeException(), isInstanceOf<Exception>());
  });

  testWidgets('resetAll', (tester) async {
    var widget = resetAllWidget();
    await inject(tester, widget);
    var syncTest = widget.controllerForTest<SyncTestController>();
    expect(syncTest.model.value, 333);
    var counter = widget.controllerForTest<CounterController>();
    counter.increment();
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    counter.increment();
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.byKey(resetAllButtonKey));
    await tester.pumpAndSettle();
    expect(syncTest.model.value, 0);
    expect(find.text('0'), findsOneWidget);
  });
}
