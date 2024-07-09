// ignore: file_names
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:find_food/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onPageChanged;
  bool allowSelect=true;

  BottomNavigationBarWidget(
    {
      super.key, 
      required this.currentIndex,
      required this.onPageChanged,
      this.allowSelect=true
    });



  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationCurve: Curves.easeInOut,

      animationDuration: allowSelect ? const Duration(milliseconds: 300) :const Duration(milliseconds: 9999999),
      color: AppColors.primary,
      height: 70,
      backgroundColor: Colors.transparent, // Sử dụng màu trong suốt
      index: currentIndex,
      
      onTap:allowSelect? (index) {
        onPageChanged(index);
      }:null,

      items: const [
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.add_box,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.notifications,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
      ],
    );
  }
}
