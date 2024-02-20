// import 'package:finwise/core/constants/color_constant.dart';
// import 'package:finwise/core/constants/svg_name_constant.dart';
// import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
// import 'package:finwise/core/helpers/icon_helper.dart';
// import 'package:finwise/core/helpers/text_style_helper.dart';
// import 'package:finwise/core/helpers/ui_helper.dart';
// import 'package:finwise/modules/smart_goal/widgets/calendar_widget.dart';
// import 'package:finwise/modules/smart_goal/widgets/forms/smart_goal_form_item.dart';
// import 'package:finwise/modules/smart_goal/widgets/smart_goal_prediction.dart';
// import 'package:flutter/material.dart';

// class SmartGoalTargetDate extends StatefulWidget {
//   late bool setDue = false;
//   TextEditingController? startDateController;
//   TextEditingController? endDateController;
//   TextEditingController? contributionController;
//   SmartGoalTargetDate({
//     super.key,
//     this.setDue = false,
//     this.startDateController,
//     this.endDateController,
//     this.contributionController,
//   });

//   @override
//   State<SmartGoalTargetDate> createState() => _SmartGoalTargetDateState();
// }

// class _SmartGoalTargetDateState extends State<SmartGoalTargetDate> {
//   @override
//   Widget build(BuildContext context) {
//     return _buildTargetGoalPart();
//   }

//   Widget _buildTargetGoalPart() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: RadioMenuButton(
//                 value: true,
//                 groupValue: widget.setDue,
//                 onChanged: (value) => setState(() => widget.setDue = true),
//                 child: const Text('Set'),
//               ),
//             ),
//             Expanded(
//               child: RadioMenuButton(
//                 value: false,
//                 groupValue: widget.setDue,
//                 onChanged: (value) => setState(() => widget.setDue = false),
//                 child: const Text("Don't Set"),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Visibility(
//           visible: widget.setDue,
//           child: Row(
//             children: [
//               Expanded(
//                   child: _buildDate(
//                 hintText: 'Start Date',
//                 controller: widget.startDateController,
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() {
//                     widget.startDateController.text =
//                         UIHelper.getInputDate(selectedDay.toString());
//                     widget.selectedStartDate = selectedDay;
//                   });
//                 },
//               )),
//               const SizedBox(width: 8),
//               Expanded(
//                   child: _buildDate(
//                 hintText: 'End Date',
//                 controller: widget.endDateController,
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() {
//                     widget.endDateController.text =
//                         UIHelper.getInputDate(selectedDay.toString());
//                     _selectedEndDate = selectedDay;
//                   });
//                 },
//               )),
//             ],
//           ),
//         ),
//         Visibility(
//           visible: !_setDue,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: SmartGoalFormItem(
//                         color: const Color(0xffD3D5E4),
//                         label: 'Monthly Contribution',
//                         controller: _contributionController,
//                         readOnly: true),
//                   ),
//                   const Expanded(child: SizedBox()),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const SmartGoalPrediction(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDate({
//     String hintText = '',
//     TextEditingController? controller,
//     required void Function(DateTime selectedDay, DateTime focusedDay)
//         onDaySelected,
//   }) {
//     return TextFormField(
//       controller: controller,
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => CalendarWidget(
//               onDaySelected: onDaySelected,
//             ),
//           ),
//         );
//       },
//       style: TextStyleHelper.getw500size(14),
//       readOnly: true,
//       decoration: InputDecoration(
//         isDense: true,
//         contentPadding: EdgeInsets.zero,
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none),
//         fillColor: Colors.white,
//         filled: true,
//         prefixIcon: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: IconHelper.getSVG(
//             SVGName.calendar,
//             color: ColorConstant.mainText,
//           ),
//         ),
//         hintText: hintText,
//         hintStyle: GeneralTextStyle.getSize(12, color: ColorConstant.thin),
//       ),
//     );
//   }
// }
