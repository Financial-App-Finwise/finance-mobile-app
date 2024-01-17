import 'package:finwise/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/widgets/test_container.dart';

class AuthScreenLayout extends StatefulWidget {
  const AuthScreenLayout({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.buttonLabel = '',
    required this.bottomContent,
  });

  final String title;
  final String subtitle;
  final String buttonLabel;
  final Widget bottomContent;

  @override
  State<AuthScreenLayout> createState() => _AuthScreenLayoutState();
}

class _AuthScreenLayoutState extends State<AuthScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: GestureDetector(
          child: _buildBody(),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
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
                    widget.bottomContent,
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
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.topLeft,
        child: Icon(Icons.arrow_back),
      ),
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
            widget.title,
            style: _textTheme.headlineMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            widget.subtitle,
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
            obscureText: true,
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

  // TODO
  // better make it as a component

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
                // TODO
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
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
            widget.buttonLabel,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
