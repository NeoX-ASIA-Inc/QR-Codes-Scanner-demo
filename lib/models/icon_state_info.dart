//Class AppState dung để lưu trạng thái của ứng dụng
//Ở đây trạng thái là trại thái của icon 1, 2 và button.
class Icon_State_Info {
  int id;
  String name;
  bool scanned_status;

  Icon_State_Info({
    required this.id,
    required this.name,
    required this.scanned_status,
  });

  factory Icon_State_Info.fromJson(Map<String, dynamic> json) {
    return Icon_State_Info(
      id: json['id'] ?? false,
      name: json['name'] ?? false,
      scanned_status: json['scanned_status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'scanned_status': scanned_status,
    };
  }
}
