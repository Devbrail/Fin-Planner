import 'package:flutter/material.dart';

showMaterialSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.surface,
    ),
  );
}

/// Groups the elements in [values] by the value returned by [key].
///
/// Returns a map from keys computed by [key] to a list of all values for which
/// [key] returns that key. The values appear in the list in the same relative
/// order as in [values].
Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}

double validDate(String amount) {
  double amountInt = double.parse(amount);
  return amountInt;
}
