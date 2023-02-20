import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_cow/core/app/colors.dart';
import 'package:movie_cow/core/app/styles.dart';
import 'package:movie_cow/core/providers/example_provider.dart';
import 'package:movie_cow/views/home.dart';
import 'package:movie_cow/views/widgets/loading_widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // Read a value or call a function using a provider like below:
              ref.read(exampleProvider).exampleVariableLogin,
              style: AppStyles.exampleTextstyle2,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:
                    Size(MediaQuery.of(context).size.width * 0.5, 30.0),
                backgroundColor: AppColors.exampleColorSwatch.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: (() async {
                // Simulate fake login delay and show loading spinner
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: const LoaderWidget(),
                    );
                  },
                  barrierDismissible: false,
                );
                await Future<void>.delayed(const Duration(seconds: 2));

                // Navigate to the home screen
                Navigator.of(context).pushAndRemoveUntil<void>(
                  CupertinoPageRoute<void>(
                      builder: (BuildContext context) => const HomeView()),
                  ModalRoute.withName('/home'),
                );
              }),
              child: Text(
                'Login',
                style: AppStyles.exampleTextstyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
