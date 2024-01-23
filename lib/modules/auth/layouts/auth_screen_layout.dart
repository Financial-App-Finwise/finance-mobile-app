import 'package:finwise/core/constants/auth_text_style_constant.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:finwise/core/constants/color_constant.dart';

class AuthScreenLayout extends StatefulWidget {
  const AuthScreenLayout({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.buttonLabel = '',
    required this.bottomContent,
    required this.formArea,
    this.isFormFilled = false,
    this.onButtonTap,
  });

  final String title;
  final String subtitle;
  final String buttonLabel;
  final Widget bottomContent;
  final Widget formArea;
  final bool isFormFilled;
  final void Function()? onButtonTap;

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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    // _buildTextFields(),
                    widget.formArea,
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
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.topLeft,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildTopContent() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 12, bottom: 32),
      // color: Colors.orange[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AuthScreenTextStyle.topContentTitle,
          ),
          Text(
            widget.subtitle,
            style: AuthScreenTextStyle.topContentSubtitle,
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      // color: Colors.blue[200],
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        // horizontal: 16,
      ),
      child: InkWell(
        onTap: widget.isFormFilled
            ? () {
                // TODO
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              }
            : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isFormFilled
                ? ColorConstant.secondary
                : ColorConstant.secondary.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            widget.buttonLabel,
            style: AuthScreenTextStyle.button,
          ),
        ),
      ),
    );
  }
}

//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   Color formColor = Color(0xffF2F3F7);

//   Widget _buildTextFields() {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildTextLabel(text: 'Email'),
//           FormWidget(
//             hintText: 'Email',
//             controller: _emailController,
//             prefixIcon: Icon(
//               Icons.email_outlined,
//               color: ColorConstant.mainText,
//             ),
//             onChanged: (value) {
//               setState(() => _isFormFilled);
//             },
//           ),
//           SizedBox(height: 24),
//           _buildTextLabel(text: 'Password'),
//           FormWidget(
//             obscureText: true,
//             hintText: 'Password',
//             prefixIcon: Icon(Icons.lock_outline, color: ColorConstant.mainText),
//             controller: _passwordController,
//             onChanged: (value) {
//               setState(() => _isFormFilled);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextLabel({required String text}) {
//     return Container(
//       padding: EdgeInsets.only(left: 8, bottom: 8),
//       child: Text(
//         text,
//         style: AuthScreenTextStyle.formLabel,
//       ),
//     );
//   }

//   bool get _isFormFilled =>
//       _emailController.value.text.isNotEmpty &&
//       _passwordController.value.text.isNotEmpty;



// better make it as a component, making it convenient to share with other classes

// Widget _buildTextFieldItem({
//   required TextEditingController controller,
//   required String hintText,
//   required Widget prefixIcon,
//   bool obscureText = false,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(12),
//       color: Color(0xffF2F3F7),
//     ),
//     child: TextFormField(
//       // cursorHeight: 14,
//       textAlignVertical: TextAlignVertical.center,
//       style: AuthScreenTextStyle.formText,
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: AuthScreenTextStyle.formHint,
//         prefixIcon: Container(
//           margin: EdgeInsets.all(16),
//           child: prefixIcon,
//         ),
//         // focusColor: ColorConstant.mainText,
//         border: InputBorder.none,
//         contentPadding: EdgeInsets.zero,
//       ),
//       obscureText: obscureText,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter...';
//         }
//       },
//       onChanged: (value) {
//         setState(() {
//           _isFormFilled;
//         });
//       },
//     ),
//   );
// }

