class CompanyLogoVm {
  late String companyId;
  late String fileName;

  CompanyLogoVm({this.companyId = '', this.fileName = ''});

  factory CompanyLogoVm.fromjson(Map<String, dynamic> json) {
    return CompanyLogoVm(
        companyId: json['companyId'], fileName: json['fileName']);
  }
}
