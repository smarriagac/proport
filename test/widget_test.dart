import 'package:flutter_test/flutter_test.dart';
import 'package:symmetry/app/app.dart';
import 'package:symmetry/core/di/injection.dart';

void main() {
  setUp(() async {
    await configureDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('Symmetry App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SymmetryApp());
    await tester.pump();

    // Verify 5 authentic navigation tabs exist
    expect(find.text('Amigos'), findsOneWidget);
    expect(find.text('Rangos'), findsNWidgets(2)); // Sub-tab and Bottom Nav Tab
    expect(find.text('Entrenar'), findsOneWidget);
    expect(find.text('Biblioteca'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
  });
}
