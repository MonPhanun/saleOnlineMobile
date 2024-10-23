class ComponentValuesVm {
  late String componentValueId;
  late String value;

  ComponentValuesVm({this.componentValueId = '', this.value = ''});

  factory ComponentValuesVm.fromJson(Map<String, dynamic> json) {
    return ComponentValuesVm(
        componentValueId: json['componentValueId'], value: json['value']);
  }
}
