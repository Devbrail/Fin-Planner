import 'dart:async';

import 'package:flutter/material.dart';

class FutureResolve<T> extends StatelessWidget {
  const FutureResolve({
    super.key,
    required this.future,
    required this.builder,
  });

  final Future<T> future;
  final Function(T value) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return builder.call(snapshot.data as T);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
