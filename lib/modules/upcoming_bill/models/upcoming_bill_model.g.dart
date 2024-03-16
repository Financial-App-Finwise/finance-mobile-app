// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingBill _$UpcomingBillFromJson(Map<String, dynamic> json) => UpcomingBill(
      data: (json['data'] as List<dynamic>)
          .map((e) => UpcomingBillData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: UpcomingBillMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpcomingBillToJson(UpcomingBill instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
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

UpcomingBillMeta _$UpcomingBillMetaFromJson(Map<String, dynamic> json) =>
    UpcomingBillMeta(
      currentPage: json['current_page'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 0,
    );

Map<String, dynamic> _$UpcomingBillMetaToJson(UpcomingBillMeta instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'total': instance.total,
      'per_page': instance.perPage,
    };
