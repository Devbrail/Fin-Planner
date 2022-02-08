import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../home/bloc/home_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final nameController = TextEditingController();
  late HomeBloc expenseBloc = BlocProvider.of<HomeBloc>(context)
    ..add(FetchUserDetailsEvent());

  void _updateDetails() {
    expenseBloc.add(UpdateUserDetailsEvent(name: nameController.text));
  }

  void _pickImage() {
    expenseBloc.add(PickImageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: BlocListener(
            bloc: expenseBloc,
            listener: (context, state) {
              if (state is UserDetailsUpdatedState) {
                Navigator.pop(context);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.profile,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    UserImageWidget(pickImage: _pickImage),
                    Expanded(
                      child: UserTextField(nameController: nameController),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: _updateDetails,
                    child: Text(
                      AppLocalizations.of(context)!.update,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserTextField extends StatelessWidget {
  final TextEditingController nameController;

  const UserTextField({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<HomeBloc>(context),
      builder: (context, state) {
        if (state is UserDetailsChangedState) {
          nameController.text = state.name;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextFormField(
              autocorrect: true,
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.userName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                filled: true,
              ),
              validator: (value) {
                if (value!.length >= 3) {
                  return null;
                } else {
                  return AppLocalizations.of(context)!.validName;
                }
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    Key? key,
    required this.pickImage,
  }) : super(key: key);

  final VoidCallback pickImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: pickImage,
        child: BlocBuilder(
          buildWhen: (previous, current) => current is UserDetailsChangedState,
          bloc: BlocProvider.of<HomeBloc>(context),
          builder: (context, state) {
            if (state is UserDetailsChangedState) {
              if (state.image.isEmpty) {
                return CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                );
              } else {
                if (kIsWeb) {
                  return const SizedBox.shrink();
                }

                return CircleAvatar(
                  foregroundImage: FileImage(File(state.image)),
                );
              }
            }
            return const CircleAvatar(maxRadius: 96);
          },
        ),
      ),
    );
  }
}
