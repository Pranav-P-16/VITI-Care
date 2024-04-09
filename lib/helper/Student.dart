
class Student {
  Student({
    required this.id,
    required this.Name,
    required this.Registration,
    required this.Block,
    required this.RoomNo,
    required this.isRaised,
  });
  late String id;
  late String Name;
  late String Registration;
  late String Block;
  late String RoomNo;
  late bool isRaised;

  Student.fromJson(Map<String, dynamic> json){
    id=json['id'];
    Name = json['Name'];
    Registration = json['Registration'];
    Block = json['Block'];
    RoomNo = json['Room_no'];
    isRaised = json['isRaised'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id']=id;
    data['Name'] = Name;
    data['Registration'] = Registration;
    data['Block'] = Block;
    data['Room_no'] = RoomNo;
    data['isRaised'] = isRaised;
    return data;
  }
}