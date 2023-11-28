class AppState {
  bool isIcon1Red;
  bool isIcon2Blue;
  bool isButtonEnabled;

  AppState({
    required this.isIcon1Red,
    required this.isIcon2Blue,
    required this.isButtonEnabled,
  });

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      isIcon1Red: json['isIcon1Red'] ?? false,
      isIcon2Blue: json['isIcon2Blue'] ?? false,
      isButtonEnabled: json['isButtonEnabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isIcon1Red': isIcon1Red,
      'isIcon2Blue': isIcon2Blue,
      'isButtonEnabled': isButtonEnabled,
    };
  }
}