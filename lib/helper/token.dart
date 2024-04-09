class Token {
  Token({
    required this.id,
    required this.name,
    required this.roomNo,
    required this.block,
    required this.otp,
    required this.isdone,
    required this.datetime,
  });
  late String id;
  late String name;
  late String roomNo;
  late String block;
  late String otp;
  late bool isdone;
  late String datetime;

  Token.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    roomNo = json['room_no'];
    block = json['block'];
    otp = json['otp'];
    isdone = json['isdone'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['room_no'] = roomNo;
    data['block'] = block;
    data['otp'] = otp;
    data['isdone'] = isdone;
    data['datetime'] = datetime;
    return data;
  }
}