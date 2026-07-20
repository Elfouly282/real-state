import 'package:flutter/material.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/property_details/domain/entities/property_entity.dart';

class AgentInfoWiget extends StatelessWidget {
  final PropertyEntity property;
  const AgentInfoWiget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primaryColor,
          child: Text(
            property.agentInfo?.user.name[0] ?? "",
            style: getHighStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.height * 0.008),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              property.agentInfo?.user.name ?? '',
              style: getHighStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            Text(
              property.agentInfo?.title ?? '',
              style: getLightStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(width: MediaQuery.of(context).size.height * 0.02),
        CircleAvatar(
          backgroundColor: AppColors.secondaryColor,
          child: Icon(Icons.call, color: AppColors.primaryColor),
        ),
        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
        CircleAvatar(
          backgroundColor: AppColors.secondaryColor,
          child: Icon(Icons.chat_outlined, color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
