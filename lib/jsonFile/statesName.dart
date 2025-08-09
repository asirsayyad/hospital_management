import 'dart:convert';
/// id : 1
/// name : "Andhra Pradesh"

StatesName statesNameFromJson(String str) => StatesName.fromJson(json.decode(str));
String statesNameToJson(StatesName data) => json.encode(data.toJson());
class StatesName {
  StatesName({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  StatesName.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
StatesName copyWith({  num? id,
  String? name,
}) => StatesName(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}