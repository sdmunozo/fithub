class Height {
  final double value;
  final String unit;

  Height(this.value, this.unit);

  Map<String, dynamic> toJson() => {
        'value': value,
        'unit': unit,
      };

  static Height fromJson(Map<String, dynamic> json) {
    return Height(json['value'], json['unit']);
  }
}
