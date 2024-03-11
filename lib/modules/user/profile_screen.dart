import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/initiating_screens/unimplemented_screen.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
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
          const Expanded(child: UnimplementedScreen()),
          ElevatedButton(
            onPressed: () async {
              // ---------- Dispose All Stores ----------
              context.read<FinanceStore>().dispose();

              // ---------- Logout ----------
              await context.read<AuthStore>().signOut();
            },
            child: const Text('Log out'),
          ),
          const SizedBox(height: 48),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(
      //   currentIndex: 2,
      //   onTap: () {},
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>
      //       Navigator.pushNamed(context, RouteName.transactionCreate),
      //   elevation: 0,
      //   backgroundColor: const Color(0xff00A6FB),
      //   shape: const CircleBorder(),
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
