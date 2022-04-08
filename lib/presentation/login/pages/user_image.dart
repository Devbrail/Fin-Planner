import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes.dart';
import '../../home/bloc/home_bloc.dart';
import '../../settings/widgets/user_profile_widget.dart';

class UserImagePage extends StatefulWidget {
  const UserImagePage({Key? key}) : super(key: key);

  @override
  State<UserImagePage> createState() => _UserImagePageState();
}

class _UserImagePageState extends State<UserImagePage> {
  void _pickImage() => expenseBloc.add(PickImageEvent());
  late final expenseBloc = BlocProvider.of<HomeBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Image',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Let\'s set image for you',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 16),
                UserImageWidget(
                  pickImage: _pickImage,
                  maxRadius: 42,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, splashScreen);
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
