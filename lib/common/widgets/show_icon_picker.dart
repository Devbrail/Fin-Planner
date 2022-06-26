import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<IconData> defaultCategoryIcons = [
  Icons.home_rounded,
  Icons.shopping_cart_rounded,
  Icons.fastfood_rounded,
  Icons.directions_bike_rounded,
  Icons.directions_car_rounded,
  Icons.smartphone_rounded,
  Icons.favorite,
  Icons.local_gas_station,
  Icons.apartment_rounded,
  Icons.school_rounded,
  Icons.library_books_rounded,
  Icons.sports_esports_rounded,
  Icons.self_improvement_rounded,
  Icons.hiking_rounded,
  Icons.qr_code_rounded,
  Icons.qr_code_rounded,
  Icons.local_gas_station_rounded,
  Icons.photo_camera_rounded,
  Icons.directions_bus_rounded,
  Icons.more_horiz,
];

Future<IconData?> showIconPicker({
  required BuildContext context,
  IconData? defaultIcon = Icons.home_rounded,
}) async {
  IconData? selectedIcon = defaultIcon;

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.updatedCategoryLable,
      ),
      content: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.4,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 70,
            childAspectRatio: 1 / 1,
          ),
          itemCount: defaultCategoryIcons.length,
          itemBuilder: (_, index) => IconButton(
            key: ValueKey(defaultCategoryIcons[index].codePoint),
            color: selectedIcon == defaultCategoryIcons[index]
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
            onPressed: () {
              selectedIcon = defaultCategoryIcons[index];
              Navigator.of(context).pop();
            },
            icon: Icon(defaultCategoryIcons[index]),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancelLable),
        )
      ],
    ),
  );
  return selectedIcon;
}
