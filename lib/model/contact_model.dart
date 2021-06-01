class Contact {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String country;

  Contact({this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.country});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      Contact(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'country': country,
    };
  }
}
