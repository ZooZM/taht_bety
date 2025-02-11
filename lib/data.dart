import 'package:flutter/material.dart';
import 'package:taht_bety/auth/data/models/user/user.dart';
import 'package:taht_bety/user/Features/Home/data/models/category_Model.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/provider_model.dart';

class Data {
  Data();
  static UserModel user = UserModel();
  static ProviderModel provider = ProviderModel();
  static List<ProviderModel> providers = [];
  static List<CategoryModel> categores = [
    CategoryModel(name: "A-All", hasCliced: true, icon: Icons.category),
    CategoryModel(
        name: "R-Electric", hasCliced: false, icon: Icons.electrical_services),
    CategoryModel(
        name: "R-Painters", hasCliced: false, icon: Icons.format_paint),
    CategoryModel(name: "R-Carpenters", hasCliced: false, icon: Icons.handyman),
    CategoryModel(
        name: "R-Alometetal", hasCliced: false, icon: Icons.construction),
    CategoryModel(
        name: "R-Air conditioning technician",
        hasCliced: false,
        icon: Icons.ac_unit),
    CategoryModel(name: "R-Plumber", hasCliced: false, icon: Icons.plumbing),
    CategoryModel(
        name: "HW-Standerd", hasCliced: false, icon: Icons.cleaning_services),
    CategoryModel(name: "HW-Deep", hasCliced: false, icon: Icons.layers),
    CategoryModel(
        name: "HW-Cleaning", hasCliced: false, icon: Icons.clean_hands),
    CategoryModel(name: "HW-HouseKeeper", hasCliced: false, icon: Icons.home),
    CategoryModel(
        name: "HW-Car wash", hasCliced: false, icon: Icons.local_car_wash),
    CategoryModel(
        name: "HW-Dry cleaning",
        hasCliced: false,
        icon: Icons.local_laundry_service),
    CategoryModel(
        name: "F-Restaurants", hasCliced: false, icon: Icons.restaurant),
    CategoryModel(
        name: "M-Supermarket", hasCliced: false, icon: Icons.shopping_cart),
    CategoryModel(name: "M-miqla", hasCliced: false, icon: Icons.local_dining),
    CategoryModel(
        name: "HC-Pharmacies", hasCliced: false, icon: Icons.local_pharmacy),
    CategoryModel(
        name: "HC-Clinics", hasCliced: false, icon: Icons.local_hospital),
  ];
}
