import 'package:order_up_merchant/commons/models/audit_trail.dart';

class AuditTrailUtil {
  static void toEntity(Map<String, Object> map, AuditTrail auditTrail) {
    auditTrail.id = map['id'];
    auditTrail.dateCreated = map['dateCreated'];
    auditTrail.dateModified = map['dateModified'];
    auditTrail.createdBy = map['createdBy'];
    auditTrail.modifiedBy = map['modifiedBy'];
    auditTrail.isActive = map['isActive'];
  }

  static void toMap(AuditTrail entity, Map<String, Object> map) {
    map['id'] = entity.id;
    map['dateCreated'] = entity.dateCreated;
    map['dateModified'] = entity.dateModified;
    map['createdBy'] = entity.createdBy;
    map['modifiedBy'] = entity.modifiedBy;
    map['isActive'] = entity.isActive;
  }
}