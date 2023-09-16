import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:provider/provider.dart';

class AppLanguageChanger extends StatelessWidget {
  const AppLanguageChanger({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Provider.of<Box<dynamic>>(context).listenable(
        keys: [
          appLanguageKey,
        ],
      ),
      builder: (context, value, child) {
        final String code = value.get(appLanguageKey, defaultValue: 'en');
        return ListTile(
          leading: Icon(
            MdiIcons.translate,
            color: context.onSurfaceVariant,
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width >= 700
                    ? 700
                    : double.infinity,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  maxChildSize: 1,
                  expand: false,
                  builder: (context, scrollController) {
                    final List<LanguageEntity> languages =
                        Languages.languages.sorted(
                      (a, b) => a.value.compareTo(b.value),
                    );
                    return SafeArea(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            title: Text(
                              context.loc.chooseAppLanguage,
                              style: context.titleLarge,
                            ),
                          ),
                          ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: languages.length,
                            itemBuilder: (context, index) {
                              final LanguageEntity entity = languages[index];
                              return ListTile(
                                onTap: () => value
                                    .put(appLanguageKey, entity.code)
                                    .then((value) => Navigator.pop(context)),
                                title: Text(
                                  entity.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: code == entity.code
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : null),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          title: const Text('App language'),
          subtitle: Text(Languages.languages
              .firstWhere((element) => element.code == code)
              .value),
        );
      },
    );
  }
}

class LanguageEntity {
  final String code;
  final String value;

  const LanguageEntity({
    required this.code,
    required this.value,
  });
}

class Languages {
  const Languages._();

  static const languages = [
    LanguageEntity(code: 'en', value: 'English'),
    LanguageEntity(code: 'pl', value: 'Polish'),
    LanguageEntity(code: 'be', value: 'Belarusian'),
    LanguageEntity(code: 'de', value: 'German'),
    LanguageEntity(code: 'fr', value: 'French'),
    LanguageEntity(code: 'it', value: 'Italian'),
    LanguageEntity(code: 'kn', value: 'Kannada (IN)'),
    LanguageEntity(code: 'pt', value: 'Portuguese'),
    LanguageEntity(code: 'ru', value: 'Russian'),
    LanguageEntity(code: 'ta', value: 'Tamil (IN)'),
    LanguageEntity(code: 'vi', value: 'Vietnamese'),
    LanguageEntity(code: 'zh', value: 'Chinese'),
    LanguageEntity(code: 'zh_TW', value: 'Traditional Chinese'),
  ];
}
