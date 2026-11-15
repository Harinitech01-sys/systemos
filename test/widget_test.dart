import 'package:flutter_test/flutter_test.dart';

import 'package:harinios_app/app.dart';
import 'package:harinios_app/core/theme/app_theme.dart';

void main() {
  testWidgets('HariniOS startup screen renders core branding', (tester) async {
    await tester.pumpWidget(const HariniOSApp());

    expect(find.text('HariniOS'), findsOneWidget);
    expect(find.text('Life management, simplified'), findsOneWidget);
    expect(find.text('Open dashboard'), findsOneWidget);
  });

  test('material theme definitions are enabled for light and dark modes', () {
    expect(AppTheme.lightTheme.useMaterial3, isTrue);
    expect(AppTheme.darkTheme.useMaterial3, isTrue);
    expect(AppTheme.lightTheme.colorScheme.primary, isNotNull);
    expect(AppTheme.darkTheme.colorScheme.primary, isNotNull);
  });
}
