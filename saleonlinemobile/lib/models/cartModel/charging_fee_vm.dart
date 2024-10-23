class ChargingFeeVm {
  late String name;
  late int minimumOrder;
  late double feeCharge;

  ChargingFeeVm({this.name = '', this.minimumOrder = 0, this.feeCharge = 0.0});

  factory ChargingFeeVm.fromJson(Map<String, dynamic> json) {
    return ChargingFeeVm(
        name: json['name'],
        minimumOrder: json['minimumOrder'],
        feeCharge: json['feeCharge']);
  }
}
