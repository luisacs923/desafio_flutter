import 'package:desafio_flutter/services/auth_service.dart';
import 'package:desafio_flutter/views/login.dart';
import 'package:flutter/material.dart';

//página para usuário logado, caso não esteja logado -> redireciona para tela de Login

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var user = AuthService().getUserInfo();

      if (user == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = AuthService().getUserInfo();

    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimaryFixedVariant,);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: style,),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${user?.email}',
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService().logout();
                 if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }
              }, 
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}


