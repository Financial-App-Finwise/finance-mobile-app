import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/modules/data_science/stores/insight_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  final controller = WebViewController();

  bool done = false;
  int loadingPercentage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  bool canGoBack = false;

  late final _store = context.read<InsightStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          onPressed: () => Navigator.pop(context),
          icon: IconHelper.getSVG(SVGName.arrowBack, color: Colors.white),
        ),
        flexibleSpace: FlexibleSpaceBar(
          title: const Text('My Financial Insights'),
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConstant.secondary,
                  ColorConstant.primary,
                ],
                stops: [0, 1],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _store.done = false;
              _store.loadWebPage();
            },
          ),
        ],
      ),
      body: SafeArea(child: _buildContent()),
    );
    // return GeneralSimpleHeaderLayout(
    //   title: 'My Financial Analysis',
    //   description:
    //       'Gain useful insights from the data analysis of your financial pattern',
    //   gradient: LinearGradient(colors: [
    //     ColorConstant.secondary,
    //     ColorConstant.primary,
    //   ]),
    //   padding: EdgeInsets.zero,
    //   child: _buildContent(),
    // );
  }

  Widget _buildContent() {
    
    return Observer(builder: (context) {
      return Column(
        children: [
          // CustomIconButton(
          //   onPressed: () async {
          //     if (await _store.controller.canGoBack()) {
          //       _store.controller.goBack();
          //     } else {
          //       debugPrint('No history available');
          //       return;
          //     }
          //   },
          //   icon: IconHelper.getSVG(
          //     SVGName.arrowBack,
          //   ),
          // ),
          Visibility(
            visible: _store.loadingPercentage < 100,
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(10),
              percent: _store.loadingPercentage / 100,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
          ),
          Expanded(
            child: WebViewWidget(controller: _store.controller),
          ),
        ],
      );
    });
  }
}
