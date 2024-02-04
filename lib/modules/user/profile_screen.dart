import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/screens/unimplemented_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: UnimplementedScreen()),
          ElevatedButton(
            onPressed: () async {
              await context.read<AuthStore>().signOut();
            },
            child: Text('Log out'),
          ),
          SizedBox(height: 48),
        ],
      ),
    );
  }
}
