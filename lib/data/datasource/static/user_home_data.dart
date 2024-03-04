
import 'package:consultancy/view/widget/user/home/categories_page.dart';
import 'package:consultancy/view/widget/user/home/favorite_page.dart';
import 'package:consultancy/view/widget/user/home/user_bookings_page.dart';
import 'package:flutter/material.dart';

abstract class UserHomeData{
  static String lang='ar';
  static List<BottomNavigationBarItem> userBottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category_outlined),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.lock_clock),
      label: 'Bookings',
    ),
  ];
  static List<Widget> userBottomNavBarPages = [
    const FavoritePage(),
    const CategoriesPage(),
    const UserBookingsPage(),
  ];
}


