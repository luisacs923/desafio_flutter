import 'package:desafio_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

// página "Meu Perfil" onde o usuário pode editar infos de cadastro

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user = AuthService().getUserInfo();
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimaryFixedVariant,);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: style),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Name: ${user?.displayName}'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () async {
                 await AuthService().updateUserInfo(displayName: _nameController.text);
              },
              child: const Text('Save Changes'),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}