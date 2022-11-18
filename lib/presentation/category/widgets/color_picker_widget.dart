import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category_bloc.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      buildWhen: (previous, current) =>
          current is CategoryColorSelectedState ||
          current is CategorySuccessState,
      bloc: BlocProvider.of<CategoryBloc>(context),
      builder: (context, state) {
        int color = Colors.red.value;
        if (state is CategoryColorSelectedState) {
          color = state.categoryColor;
        }
        if (state is CategorySuccessState) {
          color = state.category.icon;
        }
        return ListTile(
          onTap: () {
            showColorPicker(context).then((color) {
              if (color != null) {
                BlocProvider.of<CategoryBloc>(context)
                    .add(CategoryColorSelectedEvent(color.value));
              }
            });
          },
          leading: Icon(
            Icons.color_lens,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text('Color picker'),
          subtitle: Text('set colour to your category'),
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

Future<Color?> showColorPicker(
  BuildContext context, {
  Color defaultColor = Colors.red,
}) async {
  final color = await showModalBottomSheet<Color>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    constraints: BoxConstraints(
      maxWidth:
          MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
    ),
    elevation: 10,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          shrinkWrap: true,
          itemCount: Colors.primaries.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width >= 700 ? 9 : 6,
          ),
          itemBuilder: (_, index) {
            final color = Colors.primaries[index].shade500;
            return GestureDetector(
              onTap: () => Navigator.pop(context, color),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: color,
                ),
              ),
            );
          },
        ),
      );
    },
  );
  return color ?? defaultColor;
}
