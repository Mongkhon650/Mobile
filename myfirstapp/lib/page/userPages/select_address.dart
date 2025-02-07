import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_button.dart';
import 'package:myfirstapp/components/select_address_bar.dart';
import 'package:myfirstapp/components/userComponents/userServices/add_address_button.dart';
import 'package:myfirstapp/page/userPages/add_address_user.dart';
import 'package:myfirstapp/page/userPages/checklist_page.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/models/address_provider.dart';

class SelectAddress extends StatelessWidget {
  const SelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const SelectAddressBar(),
              ],
              body: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: addressProvider.addresses.isEmpty
                          ? const Center(
                        child: Text(
                          "ไม่มีที่อยู่",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                          : ListView.builder(
                        itemCount: addressProvider.addresses.length,
                        itemBuilder: (context, index) {
                          final address = addressProvider.addresses[index];
                          return ListTile(
                            leading: Checkbox(
                              value: addressProvider.selectedAddressIndex == index,
                              onChanged: (value) {
                                addressProvider.toggleSelection(index);
                              },
                            ),
                            title: Text(address.name),
                            subtitle: Text(address.province),
                            trailing: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                addressProvider.removeAddress(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    AddAddressButton(
                      onTap: () async {
                        final newAddress = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddAddressUser()),
                        );
                        if (newAddress != null) {
                          addressProvider.addAddress(newAddress);
                        }
                      },
                      text: "เพิ่มที่อยู่",
                    ),
                    if (addressProvider.addresses.isNotEmpty &&
                        addressProvider.selectedAddressIndex != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MyButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ChecklistPage()),
                            );
                          },
                          text: "ชำระเงิน",
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
