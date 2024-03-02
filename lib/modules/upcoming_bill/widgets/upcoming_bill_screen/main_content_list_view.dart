import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/upcoming_bill_enum.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/filter_bar.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/screens/upcoming_bill_detail_screen.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainContentListView extends StatefulWidget {
  final int totalUpcomingBill;
  final List<UpcomingBillData> upcomingBillList;

  const MainContentListView({
    super.key,
    required this.totalUpcomingBill,
    required this.upcomingBillList,
  });

  @override
  State<MainContentListView> createState() => _MainContentListViewState();
}

class _MainContentListViewState extends State<MainContentListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _totalBudget(),
        const SizedBox(
          height: 16,
        ),
        GeneralFilterBarHeader(
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
          return loadingStatus == LoadingStatusEnum.loading
              ? Text('loading...')
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.upcomingBillList.length,
                  itemBuilder: (context, index) {
                    List<UpcomingBillData> data = widget.upcomingBillList;
    
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.upcomingBillDetail,
                              arguments: data[index],
                            );
                          },
                          child: _upcomingBillCard(
                            data[index].date,
                            data[index].amount,
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

  // Total budget
  Widget _totalBudget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              height: 36,
              width: 36,
              child: IconConstant.getUpcomingBill(
                color: const Color(0xFFC64608),
              ),
            ),

            const SizedBox(
              width: 12,
            ),
            // Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total upcoming bill',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333652),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  '${widget.totalUpcomingBill}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.overbudget,
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
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
                UIHelper.getInputDate(date),
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
