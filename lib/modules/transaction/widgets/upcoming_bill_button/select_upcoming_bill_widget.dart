import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/upcoming_bill_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/buttons/select_item_button.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/general_date_picker.dart';
import 'package:finwise/core/layouts/general_sticky_header_layout.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SelectUpcomingBillWidget extends StatefulWidget {
  late void Function(UpcomingBillData) onItemSelected;

  SelectUpcomingBillWidget({
    super.key,
    required this.onItemSelected,
  });

  @override
  State<SelectUpcomingBillWidget> createState() =>
      _SelectUpcomingBillWidgetState();
}

class _SelectUpcomingBillWidgetState extends State<SelectUpcomingBillWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      if (mounted) {
        await context.read<UpcomingBillStore>().read(refreshed: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GeneralStickyHeaderLayout(
      title: 'Select Upcoming bill',
      description:
          'Effortlessly manage your upcoming bill with a powerful simple tool in Finwise.',
      gradient: const LinearGradient(colors: [
        Color(0xFF0ABDE3),
        Color(0xFF0B8AAF),
      ]),
      centerContent: GeneralDatePicker(
        prefix: IconHelper.getSVG(SVGName.contentManagerDashboard),
        suffix: IconHelper.getSVG(SVGName.addSquare,
            color: ColorConstant.secondary),
        onSuffix: () => Navigator.pushNamed(context, RouteName.addUpcomingBill),
        onDateChanged: (DateTime date) async {
          context.read<UpcomingBillStore>().setStartDate(date);
          context.read<UpcomingBillStore>().read(refreshed: true);
        },
      ),
      mainContent: _buildContent(),
      centerContentPadding: const EdgeInsets.all(16),
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            context.read<UpcomingBillStore>().read();
            return true;
          }
        }
        return true;
      },
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<UpcomingBillStore>().read(refreshed: true);
      },
      child: Observer(builder: (context) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 16,
            ),
            child: _mainContentListView(),
          ),
        );
      }),
    );
  }

  Widget _mainContentListView() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        GeneralFilterBarHeader(
          physics: const BouncingScrollPhysics(),
          items: [
            FilterBarHeaderItem(
              title: 'All',
              value: UpcomingBillFilterEnum.all,
            ),
            FilterBarHeaderItem(
              title: 'Tomorrow',
              value: UpcomingBillFilterEnum.tomorrow,
            ),
            FilterBarHeaderItem(
              title: 'This-week',
              value: UpcomingBillFilterEnum.thisWeek,
            ),
          ],
          onTap: (value) async {
            context.read<UpcomingBillStore>().setFilter(value);
            await context.read<UpcomingBillStore>().read(refreshed: true);
          },
          currentValue: context.read<UpcomingBillStore>().filter,
        ),
        const SizedBox(
          height: 16,
        ),
        Observer(builder: (context) {
          LoadingStatusEnum loadingStatus =
              context.watch<UpcomingBillStore>().status;
          List<UpcomingBillData> upcomingBills =
              context.watch<UpcomingBillStore>().upcomingBill.data;

          return loadingStatus == LoadingStatusEnum.loading
              ? CircularProgressIndicatorTwoArcs()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: upcomingBills.length,
                  itemBuilder: (context, index) {
                    List<UpcomingBillData> data = upcomingBills;

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            widget.onItemSelected(data[index]);
                            Navigator.pop(context);
                          },
                          child: _upcomingBillCard(
                            data[index].date,
                            data[index].amount.toDouble(),
                            data[index].name,
                          ),
                        ),
                        if (index < data.length - 1)
                          const SizedBox(
                            height: 16,
                          ),
                      ],
                    );
                  },
                );
        }),
      ],
    );
  }

  Widget _upcomingBillCard(String date, double amount, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstant.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConstant.overbudgetIcon,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconConstant.internet,
              ),
              const SizedBox(
                width: 11,
              ),
              Text(
                UIHelper.getDateFormat(date, 'dd MMM, yyyy'),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 1,
                  color: ColorConstant.black,
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xFFF2F2F2),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 0.75,
                  color: ColorConstant.mainText,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                '\$$amount',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  letterSpacing: 1,
                  color: ColorConstant.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
