import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_button.dart';
import 'package:myfirstapp/utils/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myfirstapp/utils/config.dart';

class AddAddressUser extends StatefulWidget {
  const AddAddressUser({super.key});

  @override
  State<AddAddressUser> createState() => _AddAddressUserState();
}

class _AddAddressUserState extends State<AddAddressUser> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  String _addressLabel = "บ้าน"; // ค่าเริ่มต้น "บ้าน"
  bool _isDefault = false;
  double? _latitude;
  double? _longitude;
  bool _isLoading = false;

  //ดึงตำแหน่ง GPS และแปลงเป็นที่อยู่
  void _fetchCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    Position? position = await LocationService.getCurrentLocation();
    if (position != null) {
      Map<String, String>? address = await LocationService.getAddressFromCoordinates(position);

      if (address != null) {
        setState(() {
          _streetController.text = address["street"] ?? "";
          _districtController.text = address["district"] ?? "";
          _cityController.text = address["city"] ?? "";
          _provinceController.text = address["province"] ?? "";
          _postalCodeController.text = address["postal_code"] ?? "";
          _latitude = position.latitude;
          _longitude = position.longitude;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ไม่สามารถดึงตำแหน่งของคุณได้")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  // ันทึกที่อยู่ลงฐานข้อมูลผ่าน API
  Future<void> _saveAddressToDatabase() async {
    if (!_formKey.currentState!.validate()) return; // ตรวจสอบว่าผ่าน Validation หรือไม่

    final url = Uri.parse("${AppConfig.baseUrl}/api/addresses");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": 1, // เปลี่ยนเป็น user_id ของผู้ใช้ที่ล็อกอิน
        "name": _nameController.text,
        "street": _streetController.text,
        "district": _districtController.text,
        "city": _cityController.text,
        "province": _provinceController.text,
        "postal_code": _postalCodeController.text,
        "phone_number": _phoneController.text,
        "latitude": _latitude,
        "longitude": _longitude,
        "address_label": _addressLabel,
        "is_default": _isDefault ? 1 : 0,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("เพิ่มที่อยู่สำเร็จ")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("เกิดข้อผิดพลาด: ${response.body}")),
      );
    }
  }

  // รียกใช้ `_saveAddressToDatabase()` เมื่อกดปุ่ม "เพิ่มที่อยู่"
  void _addAddress() {
    if (_formKey.currentState!.validate()) {
      _saveAddressToDatabase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เพิ่มที่อยู่")),
      body: Container(
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // บังคับกรอกข้อมูล
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "ชื่อที่อยู่"),
                  validator: (value) => value!.isEmpty ? "กรุณากรอกชื่อที่อยู่" : null,
                ),
                TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(labelText: "ที่อยู่ (ถนน / หมู่บ้าน)"),
                  validator: (value) => value!.isEmpty ? "กรุณากรอกที่อยู่" : null,
                ),
                TextFormField(
                  controller: _districtController,
                  decoration: InputDecoration(labelText: "ตำบล"),
                  validator: (value) => value!.isEmpty ? "กรุณากรอกตำบล" : null,
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: "อำเภอ"),
                  validator: (value) => value!.isEmpty ? "กรุณากรอกอำเภอ" : null,
                ),
                TextFormField(
                  controller: _provinceController,
                  decoration: InputDecoration(labelText: "จังหวัด"),
                  validator: (value) => value!.isEmpty ? "กรุณากรอกจังหวัด" : null,
                ),
                TextFormField(
                  controller: _postalCodeController,
                  decoration: InputDecoration(labelText: "รหัสไปรษณีย์"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "กรุณากรอกรหัสไปรษณีย์" : null,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: "เบอร์โทรศัพท์"),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? "กรุณากรอกเบอร์โทรศัพท์" : null,
                ),

                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _fetchCurrentLocation,
                  icon: Icon(Icons.location_on),
                  label: Text("ใช้ตำแหน่งปัจจุบัน"),
                ),

                if (_latitude != null && _longitude != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("ละติจูด: $_latitude, ลองจิจูด: $_longitude"),
                  ),

                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _addressLabel,
                  items: ["บ้าน", "ที่ทำงาน"].map((label) {
                    return DropdownMenuItem(value: label, child: Text(label));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _addressLabel = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: "ประเภทที่อยู่"),
                ),

                SwitchListTile(
                  title: Text("ตั้งเป็นที่อยู่เริ่มต้น"),
                  value: _isDefault,
                  onChanged: (value) {
                    setState(() {
                      _isDefault = value;
                    });
                  },
                ),

                SizedBox(height: 20),
                _isLoading ? Center(child: CircularProgressIndicator()) : MyButton(onTap: _addAddress, text: "เพิ่มที่อยู่"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
