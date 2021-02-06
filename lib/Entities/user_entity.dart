class UserEntity {
  String id, name, email, password, phone, userType;
  UserEntity({this.email, this.id, this.name, this.password, this.userType});

  Map<String, dynamic> toMap() {
    return {'nume': this.name, 'email': this.email, 'rol': this.userType};
  }

  UserEntity fromMap(Map<String, dynamic> map) {
    return UserEntity(
        email: map['email'], name: map['nume'], userType: map['rol']);
  }
}
