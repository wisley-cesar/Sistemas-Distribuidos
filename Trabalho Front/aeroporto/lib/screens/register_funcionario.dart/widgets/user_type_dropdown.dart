import 'package:aeroporto/screens/register_funcionario.dart/controllers/register_controller.dart';
import 'package:aeroporto/util/user_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTypeDropdown extends StatelessWidget {
  const UserTypeDropdown({super.key});

  IconData _getIconForType(UserType type) {
    switch (type) {
      case UserType.ADMIN:
        return Icons.admin_panel_settings;
      case UserType.FUNCIONARIO:
        return Icons.work;
      case UserType.PASSAGEIRO:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();

    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<UserType>(
              value: controller.selectedUserType.value,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.blue.shade700,
                size: 28,
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              elevation: 8,
              items: UserType.values
                  .where((type) => type != UserType.PASSAGEIRO)
                  .map((UserType type) {
                return DropdownMenuItem<UserType>(
                  value: type,
                  child: Row(
                    children: [
                      Icon(
                        _getIconForType(type),
                        color: Colors.blue.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        type.label,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (UserType? newValue) {
                if (newValue != null) {
                  controller.setUserType(newValue);
                }
              },
              selectedItemBuilder: (BuildContext context) {
                return UserType.values
                    .where((type) => type != UserType.PASSAGEIRO)
                    .map((UserType type) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(
                          _getIconForType(type),
                          color: Colors.blue.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          type.label,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ));
  }
}
