Map<String, double> mergeProbabilities(Map<String, double> a, Map<String, double> b) {
  final merged = <String, double>{};
  for (final k in {...a.keys, ...b.keys}) {
    final va = a[k] ?? 0.0;
    final vb = b[k] ?? 0.0;
    merged[k] = (va + vb) / 2.0;
  }

  // Normalize to sum to 100
  final total = merged.values.fold<double>(0.0, (s, e) => s + e);
  if (total <= 0) {
    final keys = merged.keys.toList();
    final equal = keys.isEmpty ? 0.0 : 100.0 / keys.length;
    return {for (var k in keys) k: equal};
  }
  return merged.map((k, v) => MapEntry(k, (v / total) * 100.0));
}
