import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/layouts/general_simple_header_layout.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
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
        title: Text('My Financial Insights'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _store.done = false;
              _store.loadWebPage();
            },
          ),
        ],
      ),
      body: SafeArea(child: _buildContent()),
    );
    return GeneralSimpleHeaderLayout(
      title: 'My Financial Analysis',
      description:
          'Gain useful insights from the data analysis of your financial pattern',
      gradient: LinearGradient(colors: [
        ColorConstant.secondary,
        ColorConstant.primary,
      ]),
      padding: EdgeInsets.zero,
      child: _buildContent(),
    );
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
            visible: loadingPercentage < 100,
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(10),
              percent: loadingPercentage / 100,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
          ),
          Expanded(
            child: !_store.done
                ? const Center(
                    child: CircularProgressIndicatorTwoArcs(),
                  )
                : WebViewWidget(controller: _store.controller),
          ),
        ],
      );
    });
  }
}
