import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<IconData> _defaultCategoryIcons = [
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
  Icons.photo_camera_rounded,
  Icons.directions_bus_rounded,
  Icons.eco_rounded,
  Icons.pets_rounded,
  Icons.water_drop_rounded,
  Icons.vaccines_rounded,
  Icons.forest_rounded,
  Icons.emoji_objects_rounded,
  Icons.outdoor_grill_rounded,
  Icons.new_releases_rounded,
  Icons.smoking_rooms_rounded,
  Icons.wifi_rounded,
  Icons.liquor_rounded,
  Icons.breakfast_dining_rounded,
];
Future<IconData?> showIconPicker({
  required BuildContext context,
  IconData? defaultIcon = Icons.home_rounded,
}) async {
  IconData? selectedIcon = defaultIcon;

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.selectIconLable),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.4,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 70,
            childAspectRatio: 1 / 1,
          ),
          shrinkWrap: true,
          itemCount: _defaultCategoryIcons.length,
          itemBuilder: (_, index) => IconButton(
            key: ValueKey(_defaultCategoryIcons[index].codePoint),
            color: selectedIcon == _defaultCategoryIcons[index]
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
            onPressed: () {
              selectedIcon = _defaultCategoryIcons[index];
              Navigator.of(context).pop();
            },
            icon: Icon(_defaultCategoryIcons[index]),
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
