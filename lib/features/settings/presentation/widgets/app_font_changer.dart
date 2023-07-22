import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:provider/provider.dart';

class AppFontChanger extends StatelessWidget {
  const AppFontChanger({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Provider.of<Box<dynamic>>(
        context,
        listen: false,
      ).listenable(
        keys: [
          appFontChangerKey,
        ],
      ),
      builder: (context, value, child) {
        return ListTile(
          leading: Icon(MdiIcons.formatFont),
          title: Text('Change font'),
          subtitle: Text('Switch font between system and outfit'),
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
                return FontListWidget(
                  currentFont: value.get(
                    appFontChangerKey,
                    defaultValue: 'Outfit',
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class FontListWidget extends StatefulWidget {
  const FontListWidget({super.key, required this.currentFont});

  final String currentFont;

  @override
  State<FontListWidget> createState() => _FontListWidgetState();
}

class _FontListWidgetState extends State<FontListWidget> {
  List<String> fonts = GoogleFonts.asMap().keys.toList();
  final TextEditingController textEditingController = TextEditingController();
  final ValueNotifier<String> valueNotifier = ValueNotifier('');

  late String _currentIndex = widget.currentFont;

  _save() async {
    await Provider.of<Box<dynamic>>(
      context,
      listen: false,
    ).put(appFontChangerKey, _currentIndex);
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
              'Select language',
              style: context.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PaisaTextField(
              controller: textEditingController,
              hintText: 'Search',
              keyboardType: TextInputType.name,
              onChanged: (value) {
                valueNotifier.value = value;
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: valueNotifier,
              builder: (context, String filterFont, _) {
                List<String> tempFonts = fonts;
                if (filterFont.isNotEmpty) {
                  tempFonts = fonts
                      .where((element) => element
                          .toLowerCase()
                          .contains(filterFont.toLowerCase()))
                      .toList();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: tempFonts.length,
                  itemBuilder: (context, index) {
                    final String font = tempFonts[index];
                    return RadioListTile(
                      value: font,
                      groupValue: _currentIndex,
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _currentIndex = value;
                        });
                      },
                      title: Text(
                        font,
                        style: GoogleFonts.getFont(font),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.loc.cancel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: _save,
                  child: Text(context.loc.done),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
