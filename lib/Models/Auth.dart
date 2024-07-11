class UserResponse {
  bool success;
  String message;
  Auth data;

  UserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        message: json["message"],
        data: Auth.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Auth {
  String token;
  String npk;
  String name;
  String role;

  Auth(
      {required this.token,
      required this.npk,
      required this.name,
      required this.role});
  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        token: json["token"],
        npk: json["npk"],
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "npk": npk,
        "name": name,
        "role": role,
      };
}
