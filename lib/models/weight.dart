class Weight {
  final double value;
  final String unit;

  Weight(this.value, this.unit);

  Map<String, dynamic> toJson() => {
        'value': value,
        'unit': unit,
      };

  static Weight fromJson(Map<String, dynamic> json) {
    return Weight(json['value'], json['unit']);
  }
}
