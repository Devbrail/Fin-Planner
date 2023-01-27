import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../widgets/paisa_color_picker.dart';
import '../bloc/category_bloc.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    super.key,
    required this.categoryBloc,
  });
  final CategoryBloc categoryBloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      buildWhen: (previous, current) =>
          current is CategoryColorSelectedState ||
          current is CategorySuccessState,
      bloc: categoryBloc,
      builder: (context, state) {
        int color = Colors.red.value;
        if (state is CategoryColorSelectedState) {
          color = state.categoryColor;
        }
        if (state is CategorySuccessState) {
          color = state.category.icon;
        }
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: () => paisaColorPicker(context).then((color) =>
              BlocProvider.of<CategoryBloc>(context)
                  .add(CategoryColorSelectedEvent(color))),
          leading: Icon(
            Icons.color_lens,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(context.loc.pickColorLabel),
          subtitle: Text(context.loc.pickColorDescLabel),
          trailing: Container(
            width: 32,
            height: 32,
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
