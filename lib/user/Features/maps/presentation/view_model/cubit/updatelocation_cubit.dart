import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/core/utils/api_service.dart';
part 'updatelocation_state.dart';

class UpdatelocationCubit extends Cubit<UpdatelocationState> {
  UpdatelocationCubit() : super(UpdatelocationInitial());

  final Dio _dio = Dio();

  Future<void> updateLocation({
    required double latitude,
    required double longitude,
    required String address,
    required bool isFavorite,
  }) async {
    emit(UpdatelocationLoading());
    try {
      String token = UserStorage.getUserData().token;
      final response = await ApiService(_dio).put(
        endPoint: 'users/update-me',
        data: {
          "locations": [
            {
              "coordinates": {
                "type": "Point",
                "coordinates": [longitude, latitude]
              },
              "address": address,
              "isFavorite": isFavorite,
            }
          ]
        },
        token: UserStorage.getUserData().token,
      );

      if (response['success']) {
        await UserStorage.updateUserData(
          lat: latitude.toString(),
          long: longitude.toString(),
          address: address,
        );

        emit(UpdatelocationSuccess());
      } else {
        emit(UpdatelocationError("Failed to update location."));
      }
    } catch (e) {
      emit(UpdatelocationError("An error occurred while updating location."));
    }
  }
}
