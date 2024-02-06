import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/financial_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:flutter/material.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
                FocusNode(),
              ),
          child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Container(
      color: ColorConstant.backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
              icon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: IconHelper.getSVG(SVGName.close),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Choose Currency',
                            style: FiancialTextStyle.updateBalanceTitle)
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildCurrencySelection(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildSearch(),
          _buildCurrencyList(),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorConstant.divider,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,

          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          prefixIcon: Container(
              // prevent Icon from stretching to the max size in this container
              color: ColorConstant.backgroundColor,
              padding: EdgeInsets.only(left: 12, right: 12),
              child:
                  IconHelper.getSVG(SVGName.search, color: ColorConstant.thin)),
          // prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
          hintText: 'Search',
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: ColorConstant.thin,
          ),
        ),
      ),
    );
  }

  final _currencyList = [
    {
      'icon': SVGName.rielCurrency,
      'name': 'Cambodia Riel (KHR)',
    },
    {
      'icon': SVGName.dollarCurrency,
      'name': 'United States Dollar (USD)',
    }
  ];

  Widget _buildCurrencyList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _currencyList.length,
      itemBuilder: (context, index) => _buildCurrencyItem(_currencyList[index]),
      separatorBuilder: (context, index) =>
          Divider(color: ColorConstant.divider),
    );
  }

  Widget _buildCurrencyItem(Map<String, dynamic> currency) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(children: [
        Container(
          width: 24,
          height: 24,
          child: IconHelper.getSVG(currency['icon']),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            child: Text(
              currency['name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.75,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
