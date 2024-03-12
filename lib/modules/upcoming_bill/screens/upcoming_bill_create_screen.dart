import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/screens/loading_screen.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class UpcomingBillCreateScreen extends StatefulWidget {
  final UpcomingBillData upcomingBillData;

  const UpcomingBillCreateScreen({
    super.key,
    required this.upcomingBillData,
  });

  @override
  State<UpcomingBillCreateScreen> createState() =>
      _UpcomingBillCreateScreenState();
}

class _UpcomingBillCreateScreenState extends State<UpcomingBillCreateScreen> {
  late final UpcomingBillStore store = context.read<UpcomingBillStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool success = await store.post(widget.upcomingBillData);

      if (success) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context, success);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingScreen();
  }

  Widget _buildLoadingScreen() {
    return Observer(builder: (context) {
      return store.createStatus == LoadingStatusEnum.done
          ? LoadingScreen(
              title: 'Upcoming Bill Added Successfully!',
              description: 'Please wait...\nYou will be directed back.',
              icon: IconHelper.getSVG(SVGName.check, color: Colors.white),
            )
          : LoadingScreen(
              title: 'Just a moment',
              description: 'Please wait...\nWe are preparing for you...',
              icon: IconHelper.getSVG(SVGName.transaction, color: Colors.white),
            );
    });
  }
}
