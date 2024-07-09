
import 'package:find_food/features/nav/notify/presentation/controller/notify_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifySettingPage extends GetView<NotifyController> {
  const NotifySettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=> Get.back(),
          child: Icon(Icons.arrow_back)
        ),
        title: const Text("Notification setting"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              _buildSection(
                context,
                icon: Icons.notifications_rounded,
                title: "Push Notification",
                subtitle: "For daily updates, you can enable or disable it",
                switchValue: controller.switchValue1,
              ),
              _buildSection(
                context,
                icon: Icons.sms_rounded,
                title: "Push Notification",
                subtitle: "For daily updates, you can enable or disable it",
                switchValue: controller.switchValue2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSection(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
  required RxBool switchValue,
}) {
  return ListTile(
    leading: Icon(icon, size: 24.0),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    subtitle: Text(
      subtitle,
      style: Theme.of(context).textTheme.bodySmall,
    ),
    trailing: Obx(() => Switch(
      value: switchValue.value,
      activeColor: Colors.red,
      onChanged: (value) {
        switchValue.value = value;
      },
    )),
  );
}