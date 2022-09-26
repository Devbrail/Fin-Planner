import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Future<void> showIconPicker({
  required BuildContext context,
  required Function(IconData icon) onSelectedIcon,
  IconData defaultIcon = Icons.home_rounded,
}) async {
  IconData selectedIcon = defaultIcon;
  List<String> iconKeys = iconMap.keys.toList();

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      icon: Icon(defaultIcon),
      title: Text(AppLocalizations.of(context)!.selectIconLabel),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        child: _IconPickereWidget(
          iconKeys: iconKeys,
          selectedIcon: selectedIcon,
          onSelectedIcon: (icon) {
            onSelectedIcon.call(icon);
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancelLabel),
        )
      ],
    ),
  );
}

class _IconPickereWidget extends StatefulWidget {
  const _IconPickereWidget({
    Key? key,
    required this.iconKeys,
    required this.selectedIcon,
    required this.onSelectedIcon,
  }) : super(key: key);

  final List<String> iconKeys;
  final IconData selectedIcon;
  final Function(IconData icon) onSelectedIcon;
  @override
  State<_IconPickereWidget> createState() => __IconPickereWidgetState();
}

class __IconPickereWidgetState extends State<_IconPickereWidget> {
  final controller = TextEditingController();
  late List<String> iconKeys = widget.iconKeys;
  late IconData? selectedIcon = widget.selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            iconKeys = widget.iconKeys
                .where((element) => element
                    .toLowerCase()
                    .contains(value.toLowerCase().replaceAll(' ', '')))
                .toList();
            setState(() {});
          },
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 70,
              childAspectRatio: 1 / 1,
            ),
            shrinkWrap: true,
            itemCount: iconKeys.length,
            itemBuilder: (_, index) => IconButton(
              key: ValueKey(iconKeys[index].hashCode),
              color: selectedIcon == MdiIcons.fromString(iconKeys[index])
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
              onPressed: () {
                selectedIcon = MdiIcons.fromString(iconKeys[index]);
                widget.onSelectedIcon.call(selectedIcon ?? MdiIcons.home);
              },
              icon: Icon(MdiIcons.fromString(iconKeys[index])),
            ),
          ),
        ),
      ],
    );
  }
}
