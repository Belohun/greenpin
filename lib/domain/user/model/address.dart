class Address {
  const Address({
    required this.city,
    required this.street,
    required this.name,
    required this.isDeliveryAddress,
    required this.houseNumber,
  });

  final String name;
  final String city;
  final String street;
  final String houseNumber;
  final bool isDeliveryAddress;
}
