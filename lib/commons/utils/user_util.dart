import 'package:order_up_merchant/commons/models/user.dart';
import 'package:order_up_merchant/commons/utils/audit_trail_util.dart';

class UserUtil {
  static User toEntity(Map<String, Object> map) {
    User user = User();
    AuditTrailUtil.toEntity(map, user);
    user.firstName = map['firstName'];
    user.lastName = map['lastName'];
    user.location = map['location'];
    user.birthDate = map['birthDate'];
    user.age = map['age'];
    user.gender = map['gender'];
    user.email = map['email'];
    user.contactNo = map['contactNo'];
    user.store = map['store'];
    return user;
  }

  static Map<String, Object> toMap(User user) {
    Map<String, Object> map = {};
    AuditTrailUtil.toMap(user, map);
    map['firstName'] = user.firstName;
    map['lastName'] = user.lastName;
    map['location'] = user.location;
    map['birthDate'] = user.birthDate;
    map['age'] = user.age;
    map['gender'] = user.gender;
    map['email'] = user.email;
    map['contactNo'] = user.contactNo;
    map['store'] = user.store;
    return map;
  }

}