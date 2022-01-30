// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_list_content_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeListContentResponseDto _$EmployeeListContentResponseDtoFromJson(
    Map<String, dynamic> json) {
  return EmployeeListContentResponseDto(
    modificationCounter: json['modificationCounter'] as int,
    id: json['id'] as int,
    employeeId: json['employeeId'] as int,
    name: json['name'] as String,
    surname: json['surname'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$EmployeeListContentResponseDtoToJson(
        EmployeeListContentResponseDto instance) =>
    <String, dynamic>{
      'modificationCounter': instance.modificationCounter,
      'id': instance.id,
      'employeeId': instance.employeeId,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
    };
