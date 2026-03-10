class GoogleProfilesResponse {
  final bool? success;
  final bool? autoOnboard;
  final bool? singleProfile;
  final String? token;
  final GoogleProfileTokens? tokens;
  final String? userType;
  final String? id;
  final String? email;
  final String? name;
  final String? clientUserId;
  final bool? adminAccess;
  final bool? isApproved;
  final bool? isprofileCompleted;
  final String? profileId;
  final String? humanAgentProfileId;
  final String? clientProfileId;
  final List<SelectableProfile>? profiles;

  GoogleProfilesResponse({
    this.success,
    this.autoOnboard,
    this.singleProfile,
    this.token,
    this.tokens,
    this.userType,
    this.id,
    this.email,
    this.name,
    this.clientUserId,
    this.adminAccess,
    this.isApproved,
    this.isprofileCompleted,
    this.profileId,
    this.humanAgentProfileId,
    this.clientProfileId,
    this.profiles,
  });

  factory GoogleProfilesResponse.fromJson(Map<String, dynamic> json) {
    return GoogleProfilesResponse(
      success: json['success'] as bool?,
      autoOnboard: json['autoOnboard'] as bool?,
      singleProfile: json['singleProfile'] as bool?,
      token: json['token'] as String?,
      tokens: json['tokens'] != null
          ? GoogleProfileTokens.fromJson(json['tokens'] as Map<String, dynamic>)
          : null,
      userType: json['userType'] as String?,
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      clientUserId: json['clientUserId'] as String?,
      adminAccess: json['adminAccess'] as bool?,
      isApproved: json['isApproved'] as bool?,
      isprofileCompleted: json['isprofileCompleted'] as bool?,
      profileId: json['profileId'] as String?,
      humanAgentProfileId: json['humanAgentProfileId'] as String?,
      clientProfileId: json['clientProfileId'] as String?,
      profiles: (json['profiles'] as List?)
          ?.map((e) => SelectableProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'autoOnboard': autoOnboard,
      'singleProfile': singleProfile,
      'token': token,
      'tokens': tokens?.toJson(),
      'userType': userType,
      'id': id,
      'email': email,
      'name': name,
      'clientUserId': clientUserId,
      'adminAccess': adminAccess,
      'isApproved': isApproved,
      'isprofileCompleted': isprofileCompleted,
      'profileId': profileId,
      'humanAgentProfileId': humanAgentProfileId,
      'clientProfileId': clientProfileId,
      'profiles': profiles?.map((e) => e.toJson()).toList(),
    };
  }
}

class GoogleProfileTokens {
  final String? adminToken;
  final String? clientToken;
  final String? humanAgentToken;

  GoogleProfileTokens({
    this.adminToken,
    this.clientToken,
    this.humanAgentToken,
  });

  factory GoogleProfileTokens.fromJson(Map<String, dynamic> json) {
    return GoogleProfileTokens(
      adminToken: json['adminToken'] as String?,
      clientToken: json['clientToken'] as String?,
      humanAgentToken: json['humanAgentToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminToken': adminToken,
      'clientToken': clientToken,
      'humanAgentToken': humanAgentToken,
    };
  }
}

class SelectableProfile {
  final String? userType; // client | humanAgent | admin
  final String? role; // only for humanAgent
  final String? id;
  final String? clientId;
  final String? clientUserId;
  final String? clientName;
  final String? name;
  final String? email;
  final bool? isApproved;
  final bool? isprofileCompleted;

  SelectableProfile({
    this.userType,
    this.role,
    this.id,
    this.clientId,
    this.clientUserId,
    this.clientName,
    this.name,
    this.email,
    this.isApproved,
    this.isprofileCompleted,
  });

  factory SelectableProfile.fromJson(Map<String, dynamic> json) {
    return SelectableProfile(
      userType: json['userType'] as String?,
      role: json['role'] as String?,
      id: json['id'] as String?,
      clientId: json['clientId'] as String?,
      clientUserId: json['clientUserId'] as String?,
      clientName: json['clientName'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      isApproved: json['isApproved'] as bool?,
      isprofileCompleted: json['isprofileCompleted'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'role': role,
      'id': id,
      'clientId': clientId,
      'clientUserId': clientUserId,
      'clientName': clientName,
      'name': name,
      'email': email,
      'isApproved': isApproved,
      'isprofileCompleted': isprofileCompleted,
    };
  }
}
