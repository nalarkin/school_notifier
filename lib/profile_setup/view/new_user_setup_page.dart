import 'package:flutter/material.dart';
import 'package:school_notifier/profile_setup/view/view.dart';

class NewUserWelcomePage extends StatelessWidget {
  const NewUserWelcomePage({Key? key}) : super(key: key);
  static Page page() => MaterialPage<void>(child: NewUserWelcomePage());
  // static const routeName = '/new_user_welcome_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Additional Info')),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text("Welcome to our app"),
              ),
              ElevatedButton(
                key: const Key('profileSetupForm_submitInfo_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: Colors.orangeAccent,
                ),
                onPressed: () =>
                    Navigator.of(context).push<void>(ProfileSetupPage.route()),
                    // Navigator.of(context).pushNamed(ProfileSetupPage.routeName),
                child: const Text('SUBMIT INFO'),
              ),
            ],
          )),
    ); // );
  }
}
