import 'package:flutter_test/flutter_test.dart';
import 'package:agropastio/services/diagnostic_utils.dart';

void main() {
  test('mergeProbabilities averages and normalizes correctly', () {
    final a = {'A': 30.0, 'B': 70.0};
    final b = {'A': 50.0, 'C': 50.0};

    final merged = mergeProbabilities(a, b);

    // merged before normalization would be: A: (30+50)/2=40, B:35, C:25 -> total 100
    expect(merged.length, 3);
    expect(merged['A']!, closeTo(40.0, 0.1));
    expect(merged['B']!, closeTo(35.0, 0.1));
    expect(merged['C']!, closeTo(25.0, 0.1));
  });

  test('mergeProbabilities handles empty maps', () {
    final merged = mergeProbabilities({}, {});
    expect(merged.length, 0);
  });
}
