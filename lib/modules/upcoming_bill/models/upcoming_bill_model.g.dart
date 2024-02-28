// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingBill _$UpcomingBillFromJson(Map<String, dynamic> json) => UpcomingBill(
      data: (json['data'] as List<dynamic>)
          .map((e) => UpcomingBillData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
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
      amount: json['amount'] == null
          ? 0.0
          : UpcomingBillData._stringToDouble(json['amount'] as String),
      date: json['date'] as String? ?? 'no date',
      name: json['name'] as String? ?? 'no name',
      note: json['note'] as String? ?? 'no note',
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
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      currentPage: json['current_page'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'total': instance.total,
    };
