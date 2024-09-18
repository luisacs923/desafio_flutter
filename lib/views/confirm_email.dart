import 'package:desafio_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({super.key});

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {

  Future<bool> isEmailVerified() async {
    await AuthService().getUserInfo()?.reload();
    var user = AuthService().getUserInfo();
    if (user != null) {
      return user.emailVerified;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimaryFixedVariant);

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Email', style: style),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: isEmailVerified(), 
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center (
              child: CircularProgressIndicator(),
            );
          } else {
            final emailVerified = snapshot.data;
              if (emailVerified!) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: const Text('Email verified succesfully!'),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: const Text('Email not yet verified'),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await AuthService().confirmEmail();
                        },
                        child: const Text('Send Verification Email'),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                );
              }
            }
          },
      ),
    );
  }
}