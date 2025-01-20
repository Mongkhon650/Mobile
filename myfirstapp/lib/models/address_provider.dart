import 'package:flutter/material.dart';

class Address {
  final String name;
  final String subDistrict;
  final String district;
  final String province;
  final String postalCode;
  final String phone;

  Address({
    required this.name,
    required this.subDistrict,
    required this.district,
    required this.province,
    required this.postalCode,
    required this.phone,
  });
}

class AddressProvider with ChangeNotifier {
  final List<Address> _addresses = [];
  int? _selectedAddressIndex;

  List<Address> get addresses => _addresses;

  int? get selectedAddressIndex => _selectedAddressIndex;

  Address? get selectedAddress =>
      _selectedAddressIndex != null ? _addresses[_selectedAddressIndex!] : null;

  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners();
  }

  void removeAddress(int index) {
    _addresses.removeAt(index);
    if (_selectedAddressIndex == index) {
      _selectedAddressIndex = null;
    }
    notifyListeners();
  }

  void toggleSelection(int index) {
    if (_selectedAddressIndex == index) {
      _selectedAddressIndex = null;
    } else {
      _selectedAddressIndex = index;
    }
    notifyListeners();
  }
}
