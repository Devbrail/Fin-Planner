import 'package:flutter/material.dart';
import 'package:flutter_paisa/app/routes.dart';
import 'package:flutter_paisa/common/enum/box_types.dart';
import 'package:flutter_paisa/data/settings/settings_service.dart';
import 'package:hive_flutter/adapters.dart';

class UserNamePage extends StatelessWidget {
  UserNamePage({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hi',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Welcome to Paise, What should we call you',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formState,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      if (val!.length > 3) {
                        return null;
                      } else {
                        return 'Enter name';
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formState.currentState!.validate()) {
                  final box = await Hive.openBox(BoxType.settings.stringValue);
                  await box.put(userNameKey, _nameController.text);
                  Navigator.pushNamed(context, userImageScreen);
                }
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
