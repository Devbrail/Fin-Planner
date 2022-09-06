import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/widgets/show_icon_picker.dart';

class SelectIconWidget extends StatefulWidget {
  const SelectIconWidget({
    super.key,
    required this.codePoint,
    required this.onSelectedIcon,
  });

  final int codePoint;
  final Function(int codePoint) onSelectedIcon;

  @override
  State<SelectIconWidget> createState() => _SelectIconWidgetState();
}

class _SelectIconWidgetState extends State<SelectIconWidget> {
  late int codePoint = widget.codePoint;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(AppLocalizations.of(context)!.selectIconLable),
      subtitle: Text(AppLocalizations.of(context)!.selectIconDescLable),
      leading: Icon(
        IconData(
          codePoint,
          fontFamily: 'Material Design Icons',
          fontPackage: 'material_design_icons_flutter',
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () async {
        await showIconPicker(
          context: context,
          defaultIcon: IconData(
            codePoint,
            fontFamily: 'Material Design Icons',
            fontPackage: 'material_design_icons_flutter',
          ),
          onSelectedIcon: (icon) {
            codePoint = icon.codePoint;
            setState(() {});
            widget.onSelectedIcon(codePoint);
          },
        );
      },
    );
  }
}
