import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/data/models/fav_provider_model.dart';
import 'package:taht_bety/user/Features/Home/data/models/fav_provider_storge.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/fav_item_list.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Future<List<FavProviderModel>> _fetchProviders() async {
    final providers = await FavProviderStorage.getAllProviders();
    return providers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Providers',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<List<FavProviderModel>>(
          future: _fetchProviders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return FavItemList(providers: snapshot.data!);
            } else if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(child: Text('Error loading data')),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(child: Text('No favorite providers yet')),
              );
            }
          },
        ),
      ),
    );
  }
}
