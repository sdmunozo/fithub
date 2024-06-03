class HeartRate {
  final int value;
  final String unit;

  HeartRate(this.value, this.unit);

  Map<String, dynamic> toJson() => {
        'value': value,
        'unit': unit,
      };

  static HeartRate fromJson(Map<String, dynamic> json) {
    return HeartRate(json['value'], json['unit']);
  }
}
