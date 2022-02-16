import 'package:json_annotation/json_annotation.dart';
part 'employee_list_content_response_dto.g.dart';

@JsonSerializable()
class EmployeeListContentResponseDto {
  final int modificationCounter;
  final int id;
  final int employeeId;
  final String name;
  final String surname;
  final String email;

  EmployeeListContentResponseDto(
      {required this.modificationCounter,
      required this.id,
      required this.employeeId,
      required this.name,
      required this.surname,
      required this.email});

  factory EmployeeListContentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeListContentResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeListContentResponseDtoToJson(this);
}
