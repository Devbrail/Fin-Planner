import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:paisa/src/presentation/widgets/paisa_big_button_widget.dart';

import '../../../core/common.dart';

class FontPreferenceWidget extends StatelessWidget {
  const FontPreferenceWidget({
    super.key,
    @Named('settings') required this.settings,
  });
  final Box<dynamic> settings;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet(
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
          context: context,
          builder: (_) => ChooseFontPreferenceWidget(settings: settings),
        );
      },
      title: Text(context.loc.chooseFontLabel),
      subtitle: Text(
        settings.get(userFontPreferenceKey, defaultValue: 'Outfit'),
      ),
    );
  }
}

class ChooseFontPreferenceWidget extends StatefulWidget {
  const ChooseFontPreferenceWidget({
    super.key,
    @Named('settings') required this.settings,
  });
  final Box<dynamic> settings;

  @override
  State<ChooseFontPreferenceWidget> createState() =>
      _ChooseFontPreferenceWidgetState();
}

class _ChooseFontPreferenceWidgetState
    extends State<ChooseFontPreferenceWidget> {
  late String currentIndex =
      widget.settings.get(userFontPreferenceKey, defaultValue: 'Outfit');

  final _fonts = GoogleFonts.asMap().keys.toList();

  _onChanged(String? value) {
    if (value == null) {
      return;
    }
    setState(() {
      currentIndex = value;
    });
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    final font = _fonts[index];
    return RadioListTile<String>(
      value: font,
      activeColor: Theme.of(context).colorScheme.primary,
      groupValue: currentIndex,
      onChanged: _onChanged,
      title: Text(
        font,
        style: GoogleFonts.getFont(font),
      ),
    );
  }

  _save() async {
    await widget.settings.put(userFontPreferenceKey, currentIndex);
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              context.loc.chooseFontLabel,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: _itemBuilder,
              itemCount: _fonts.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PaisaTextButton(
                  onPressed: () => Navigator.pop(context),
                  title: context.loc.cancel,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                child: PaisaTextButton(
                  onPressed: _save,
                  title: context.loc.ok,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
