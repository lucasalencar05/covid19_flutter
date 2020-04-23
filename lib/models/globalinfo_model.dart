class GlobalInfo {
  int cases;
  int active;
  int deaths;
  int recovered;

  GlobalInfo({this.cases, this.active, this.deaths, this.recovered});

  GlobalInfo.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    active = json['active'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cases'] = this.cases;
    data['active'] = this.active;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    return data;
  }
}