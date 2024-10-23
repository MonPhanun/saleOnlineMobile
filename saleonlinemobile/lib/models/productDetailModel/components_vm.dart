import 'package:saleonlinemobile/models/productDetailModel/component_values_vm.dart';

class ComponentsVm {
  late String name;
  late List<ComponentValuesVm>? components;

  ComponentsVm({this.name = '', this.components});

  factory ComponentsVm.fromJson(Map<String, dynamic> json) {
    return ComponentsVm(
        name: json['name'],
        components: (json['componentValues'] as List)
            .map((e) => ComponentValuesVm.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
