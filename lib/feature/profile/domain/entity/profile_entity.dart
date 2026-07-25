class ProfileEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String location;
  final String phone;    

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.location,
    required this.phone,
  });
}