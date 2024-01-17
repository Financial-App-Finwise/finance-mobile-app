import 'package:finwise/modules/auth/layouts/auth_screen_layout.dart';
import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/widgets/test_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthScreenLayout(
      title: 'Create Account',
      subtitle: 'Please enter your email and password to sign up',
      buttonLabel: 'Sign up',
      bottomContent: _buildBottomContent(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Container(
              // color: Colors.green[200],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // _buildArrow(),
                    _buildTopContent(),
                    _buildTextFields(),
                    _buildBottomContent(),
                    // TestContainer(
                    //   text: 'Hello',
                    // ),
                  ],
                ),
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
      // color: Colors.lightBlue[200],
      padding: EdgeInsets.symmetric(vertical: 14),
      alignment: Alignment.topLeft,
      child: Icon(Icons.arrow_back),
    );
  }

  late TextTheme _textTheme = Theme.of(context).textTheme;

  Widget _buildTopContent() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 12, bottom: 32),
      // color: Colors.orange[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Account',
            style: _textTheme.headlineMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            'Please enter your email and password to sign up',
            style: _textTheme.bodyMedium!.copyWith(
              fontFamily: FontConstant.balooThambi2Medium,
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
      // color: Colors.amber[100],
      // padding: EdgeInsets.zero,
      // alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextLabel(text: 'Email'),
          _buildTextFieldItem(
              hintText: 'Email',
              prefixIcon:
                  Icon(Icons.email_outlined, color: ColorConstant.mainText),
              controller: _emailController),
          SizedBox(height: 24),
          _buildTextLabel(text: 'Password'),
          _buildTextFieldItem(
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock_outline, color: ColorConstant.mainText),
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _buildTextLabel({required String text}) {
    return Container(
      padding: EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: ColorConstant.mainText,
          fontFamily: FontConstant.primary,
          fontWeight: FontWeight.w400,
        ),
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
        color: Color(0xffF2F3F7),
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
            color: ColorConstant.thin,
            fontSize: 14,
            fontWeight: FontWeight.w400,
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
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'I agree to Finwise ',
                style: _textTheme.bodyMedium!.copyWith(
                  fontFamily: FontConstant.balooThambi2Medium,
                ),
              ),
              Text(
                'Terms and Policy.',
                style: _textTheme.bodyMedium!.copyWith(
                    fontFamily: FontConstant.balooThambi2Medium,
                    color: ColorConstant.boldLink),
              ),
            ],
          ),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? ', style: _textTheme.bodyMedium),
              InkWell(
                child: Text(
                  'Sign In',
                  style: _textTheme.bodyMedium!.copyWith(
                      fontFamily: FontConstant.balooThambi2Medium,
                      color: ColorConstant.boldLink),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInScreen()));
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
      // color: Colors.blue[200],
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
            'Sign up',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
