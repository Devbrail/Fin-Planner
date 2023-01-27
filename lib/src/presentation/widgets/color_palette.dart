import 'package:flutter/material.dart';

class ColorPalette extends StatelessWidget {
  const ColorPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('data'),
                ),
                Divider(
                  indent: 0,
                  thickness: 1,
                  height: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'data',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Divider(
                  indent: 0,
                  thickness: 1,
                  height: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('data'),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Text(
                'Text onPrimary ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Center(
              child: Text(
                'Text onPrimaryContainer ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.secondary,
            child: Center(
              child: Text(
                'Text onSecondary ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Center(
              child: Text(
                'Text onSecondaryContainer ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.tertiary,
            child: Center(
              child: Text(
                'Text onTertiary ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: Center(
              child: Text(
                'Text onTertiaryContainer ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                'Text onSurface ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Center(
              child: Text(
                'Text onSurfaceVariant ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.surfaceTint,
            child: Center(
              child: Text(
                'Text onSurfaceVariant ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.inverseSurface,
            child: Center(
              child: Text(
                'Text onInverseSurface ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: Text(
                'Text onBackground ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.error,
            child: Center(
              child: Text(
                'Text onError ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).colorScheme.errorContainer,
            child: Center(
              child: Text(
                'Text onErrorContainer ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
