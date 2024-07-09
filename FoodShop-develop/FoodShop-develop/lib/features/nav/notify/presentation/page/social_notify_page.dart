import 'package:find_food/features/nav/notify/presentation/controller/notify_controller.dart';
//import 'package:find_food/features/nav/notify/presentation/widgets/notify_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialNotifyPage extends GetView<NotifyController> {
  SocialNotifyPage({super.key});
  final DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${currentDate.day}/${currentDate.month}/${currentDate.year}';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildCardNotify(
              context,
              img: Image.asset('assets/images/food_1.png'),
              title: 'Notification Title',
              subtitle:
                  'Ứng dụng này sẽ cho phép người dùng và chủ cửa hàng đăng bài viết, bao gồm cả video và hình ảnh.',
              trailing: formattedDate,
            ),
            _buildCardNotify(
              context,
              img: Image.asset('assets/images/food_1.png'),
              title: 'Notification Title',
              subtitle:
                  'Ứng dụng này sẽ cho phép người dùng và chủ cửa hàng đăng bài viết, bao gồm cả video và hình ảnh.',
              trailing: formattedDate,
            ),
            _buildCardNotify(
              context,
              img: null,
              title: 'Notification Title',
              subtitle:
                  'Ứng dụng này sẽ cho phép người dùng và chủ cửa hàng đăng bài viết, bao gồm cả video và hình ảnh.',
              trailing: formattedDate,
            ),
            _buildCardNotify(
              context,
              img: Image.asset('assets/images/food_1.png'),
              title: 'Notification Title',
              subtitle:
                  'Ứng dụng này sẽ cho phép người dùng và chủ cửa hàng đăng bài viết, bao gồm cả video và hình ảnh.',
              trailing: formattedDate,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCardNotify(
  BuildContext context, {
  required Image? img,
  required String title,
  required String subtitle,
  required String trailing,
}) {
  return Card(
    elevation: 0,
    color: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (img != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: 120.0,
                  height: 100.0,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: img.width,
                      height: img.height,
                      child: img,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
            ],
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        trailing,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
