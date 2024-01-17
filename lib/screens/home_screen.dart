import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: ColorConstant.backgroundColor,
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        alignment: Alignment.topRight,
        color: Colors.yellow[200],
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfile(),
              _buildFinance(),
              _buildMainFeatures(),
              _buildSpendingIncome(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox.fromSize(
                size: Size(56, 56),
                child: CircleAvatar(
                  child: Image.asset('assets/images/Avatar.png'),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back,',
                    style: TextStyle(
                      color: ColorConstant.mainText,
                      fontFamily: FontConstant.poppinsRegular,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Taylor Lauren',
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorConstant.mainText,
                      fontFamily: FontConstant.poppinsRegular,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            child: Icon(Icons.notifications_active_outlined),
          ),
        ],
      ),
    );
  }

  Widget _buildFinance() {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.green[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Finance'),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('Total Balance'),
                Text('1000'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainFeatures() {
    return Container(
      child: Text('Main Features'),
    );
  }

  Widget _buildSpendingIncome() {
    return Container(
      child: Text('Spending and Income'),
    );
  }
}
