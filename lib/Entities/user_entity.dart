class UserEntity {
  String id, name, email, password, phone, userType;
  UserEntity(
      {this.email,
      this.id,
      this.name,
      this.password,
      this.phone,
      this.userType});

  Map<String, dynamic> toMap() {
    return {
      'nume': this.name,
      'email': this.email,
      'phone': this.phone,
      'rol': this.userType
    };
  }
}
