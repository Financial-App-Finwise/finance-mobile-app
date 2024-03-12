import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/layouts/general_simple_header_layout.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DataWebViewScreen extends StatefulWidget {
  const DataWebViewScreen({super.key});

  @override
  State<DataWebViewScreen> createState() => _DataWebViewScreenState();
}

class _DataWebViewScreenState extends State<DataWebViewScreen> {
  final controller = WebViewController();

  bool done = false;
  int loadingPercentage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      controller.setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            done = false;
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            done = true;
            loadingPercentage = 100;
          });
        },
      ));
      controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      controller.setBackgroundColor(Colors.white);
      controller
          .loadRequest(Uri.parse('https://finwise-data.streamlit.app'));
      print(done);
    });
  }

  bool canGoBack = false;

  @override
  Widget build(BuildContext context) {
    return GeneralSimpleHeaderLayout(
      title: 'My Financial Analysis',
      description: 'Gain useful insights from the data analysis of your financial pattern',
      gradient: LinearGradient(colors: [
        ColorConstant.secondary,
        ColorConstant.primary,
      ]),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          CustomIconButton(
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              } else {
                debugPrint('No history available');
                return;
              }
            },
            icon: IconHelper.getSVG(
              SVGName.arrowBack,
            ),
          ),
          Visibility(
            visible: loadingPercentage < 100,
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(10),
              percent: loadingPercentage / 100,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
          ),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
