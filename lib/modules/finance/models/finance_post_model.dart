import 'package:json_annotation/json_annotation.dart';

part 'finance_post_model.g.dart';

@JsonSerializable()
class FinancePost {
  late double totalbalance;
  late int currencyID;

  FinancePost({
    this.totalbalance = 0,
    this.currencyID = 2,
  });

  Map<String, dynamic> toJson() => _$FinancePostToJson(this);
}