import 'package:flutter/material.dart';
import 'package:test/core/constants/color_constant.dart';
import 'package:test/core/constants/font_constant.dart';
import 'package:test/core/widgets/test_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildArrow(),
                  _buildTopContent(),
                  _buildTextFields(),
                  _buildBottomContent(),
                  TestContainer(
                    text: 'Hello',
                  ),
                ],
              ),
            ),
          ),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return Container(
      alignment: Alignment.topLeft,
      child: Icon(Icons.arrow_back),
    );
  }

  Widget _buildTopContent() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 32),
      color: Colors.grey[400],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Account',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            'Please enter your email and password to sign up',
            style: TextStyle(
              color: ColorConstant.mainText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color formColor = Color(0xffF2F3F7);

  Widget _buildTextFields() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildTextFieldItem(
            hintText: 'Email',
            prefixIcon: Icon(Icons.email, color: ColorConstant.mainText),
            controller: _emailController
          ),
          SizedBox(height: 24),
          _buildTextFieldItem(
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock, color: ColorConstant.mainText),
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldItem({
    required TextEditingController controller,
    required String hintText,
    required Widget prefixIcon,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: formColor,
      ),
      child: TextFormField(
        // cursorHeight: 14,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: ColorConstant.mainText,
          fontWeight: FontWeight.w400,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(16),
            child: prefixIcon,
          ),
          // focusColor: ColorConstant.mainText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter...';
          }
        },
        onChanged: (value) {
          setState(() {
            _isFormFilled;
          });
        },
      ),
    );
  }

  Widget _buildBottomContent() {
    return Container(
      child: Column(
        children: [
          Text('I agree to Finwise Terms and Policy'),
          Row(
            children: [
              Text('Already have an account?'),
              InkWell(
                child: Text('Sign In'),
                onTap: () {
                  print('hi');
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  bool get _isFormFilled =>
      _emailController.value.text.isNotEmpty &&
      _passwordController.value.text.isNotEmpty;

  Widget _buildButton() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: 50,
        // horizontal: 16,
      ),
      child: InkWell(
        onTap: _isFormFilled
            ? () {
                print('Sign up button: Please fill everything');
              }
            : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isFormFilled
                ? ColorConstant.secondary
                : ColorConstant.secondary.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
