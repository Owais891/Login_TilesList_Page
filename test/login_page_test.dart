import 'package:flutter_test/flutter_test.dart';
import 'package:orbit_tiles/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('application starts at the sign-in screen', (tester) async {
    await tester.pumpWidget(const OrbitTilesApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Email or username'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });
}
