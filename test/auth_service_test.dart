import 'package:flutter_test/flutter_test.dart';
import 'package:orbit_tiles/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AuthService authService;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    authService = AuthService();
  });

  test('remembered demo login is restored and removed on sign out', () async {
    final success = await authService.signIn(
      username: 'demo@orbit.app',
      password: 'password123',
      rememberMe: true,
    );

    expect(success, isTrue);
    expect(await authService.restoreSession(), 'Demo User');

    await authService.signOut();
    expect(await authService.restoreSession(), isNull);
  });

  test('invalid credentials are rejected without creating a session', () async {
    final success = await authService.signIn(
      username: 'demo@orbit.app',
      password: 'incorrect',
      rememberMe: true,
    );

    expect(success, isFalse);
    expect(await authService.restoreSession(), isNull);
  });

  test('login without remember me does not persist the session', () async {
    final success = await authService.signIn(
      username: 'demo',
      password: 'password123',
      rememberMe: false,
    );

    expect(success, isTrue);
    expect(await authService.restoreSession(), isNull);
  });

  test('new accounts can sign up and sign in', () async {
    final created = await authService.signUp(
      name: 'Alex Morgan',
      email: 'alex@example.com',
      password: 'secure123',
      rememberMe: false,
    );
    expect(created, isTrue);
    expect(
      await authService.signIn(
        username: 'alex@example.com',
        password: 'secure123',
        rememberMe: true,
      ),
      isTrue,
    );
    expect(await authService.restoreSession(), 'Alex Morgan');
  });

  test('duplicate account email is rejected', () async {
    await authService.signUp(
      name: 'Alex Morgan',
      email: 'alex@example.com',
      password: 'secure123',
      rememberMe: false,
    );
    final duplicate = await authService.signUp(
      name: 'Other Name',
      email: 'alex@example.com',
      password: 'another123',
      rememberMe: false,
    );
    expect(duplicate, isFalse);
  });
}
