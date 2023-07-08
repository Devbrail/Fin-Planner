import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../widgets/paisa_color_picker.dart';
import '../bloc/category_bloc.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryColorSelectedState ||
          current is CategorySuccessState,
      builder: (context, state) {
        int color = Colors.red.value;
        if (state is CategoryColorSelectedState) {
          color = state.categoryColor;
        }
        if (state is CategorySuccessState) {
          color = state.category.color ?? Colors.red.value;
        }
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: () {
            paisaColorPicker(context).then((color) =>
                BlocProvider.of<CategoryBloc>(context)
                    .add(CategoryColorSelectedEvent(color)));
          },
          leading: Icon(
            Icons.color_lens,
            color: context.primary,
          ),
          title: Text(
            context.loc.pickColor,
          ),
          subtitle: Text(
            context.loc.pickColorDesc,
          ),
          trailing: Container(
            margin: const EdgeInsets.only(right: 8),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(color),
            ),
          ),
        );
      },
    );
  }
}
