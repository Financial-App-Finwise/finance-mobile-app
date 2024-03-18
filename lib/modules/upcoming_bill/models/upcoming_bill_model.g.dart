// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingBill _$UpcomingBillFromJson(Map<String, dynamic> json) => UpcomingBill(
      totalUpcomingBills: json['totalUpcomingBills'] as int? ?? 0,
      data: (json['upcomingBills'] as List<dynamic>)
          .map((e) => UpcomingBillData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: TotalData.fromJson(json['totals'] as Map<String, dynamic>),
      links: LinkData.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpcomingBillToJson(UpcomingBill instance) =>
    <String, dynamic>{
      'totalUpcomingBills': instance.totalUpcomingBills,
      'upcomingBills': instance.data,
      'totals': instance.totals,
      'links': instance.links,
    };

UpcomingBillData _$UpcomingBillDataFromJson(Map<String, dynamic> json) =>
    UpcomingBillData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      categoryID: json['categoryID'] as int? ?? 0,
      amount: json['amount'] as int? ?? 0,
      date: json['date'] as String? ?? 'no date',
      name: json['name'] as String? ?? 'no name',
      note: json['note'] as String? ?? "You don't have any note.",
      status: json['status'] as String? ?? 'no status',
      createdAt: json['created_at'] as String? ?? 'no date',
      updatedAt: json['updated_at'] as String? ?? 'no date',
    );

Map<String, dynamic> _$UpcomingBillDataToJson(UpcomingBillData instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'categoryID': instance.categoryID,
      'amount': instance.amount,
      'date': instance.date,
      'name': instance.name,
      'note': instance.note,
      'status': instance.status,
    };

TotalData _$TotalDataFromJson(Map<String, dynamic> json) => TotalData(
      thisMonth: json['thisMonth'] as int? ?? 0,
      nextMonth: json['nextMonth'] as int? ?? 0,
      next6Months: json['next6Months'] as int? ?? 0,
      thisYear: json['thisYear'] as int? ?? 0,
      nextYear: json['nextYear'] as int? ?? 0,
    );

Map<String, dynamic> _$TotalDataToJson(TotalData instance) => <String, dynamic>{
      'thisMonth': instance.thisMonth,
      'nextMonth': instance.nextMonth,
      'next6Months': instance.next6Months,
      'thisYear': instance.thisYear,
      'nextYear': instance.nextYear,
    };

LinkData _$LinkDataFromJson(Map<String, dynamic> json) => LinkData(
      prev: json['prev'] as String? ?? 'no link',
      next: json['next'] as String? ?? 'no link',
    );

Map<String, dynamic> _$LinkDataToJson(LinkData instance) => <String, dynamic>{
      'prev': instance.prev,
      'next': instance.next,
    };
