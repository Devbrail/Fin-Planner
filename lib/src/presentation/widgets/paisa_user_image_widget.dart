import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../main.dart';
import '../../core/common.dart';
import '../../core/enum/box_types.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    Key? key,
    required this.pickImage,
    this.maxRadius,
  }) : super(key: key);

  final VoidCallback pickImage;
  final double? maxRadius;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: getIt
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .listenable(
        keys: [userImageKey],
      ),
      builder: (context, value, _) {
        String image = value.get(userImageKey, defaultValue: '');
        if (image == 'no-image') {
          image = '';
        }
        return GestureDetector(
          onTap: pickImage,
          child: Builder(
            builder: (context) {
              if (image.isEmpty) {
                return CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  maxRadius: maxRadius,
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                );
              } else {
                return Badge(
                  alignment: AlignmentDirectional.bottomEnd,
                  label: GestureDetector(
                    onTap: () {
                      value.put(userImageKey, '');
                    },
                    child: Center(
                      child: Icon(
                        MdiIcons.delete,
                        size: 8,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: CircleAvatar(
                    foregroundImage: FileImage(File(image)),
                    maxRadius: maxRadius,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
