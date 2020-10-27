import 'package:equatable/equatable.dart';
import 'package:domain/domain.dart';

abstract class GetListRestaurantState extends Equatable {
  const GetListRestaurantState();
}

class GetListRestaurantInitialState extends GetListRestaurantState {
  @override
  List<Object> get props => [];
}

class GetListRestaurantLoadingState extends GetListRestaurantState {
  @override
  List<Object> get props => [];
}

class GetListRestaurantLoadedState extends GetListRestaurantState {
  final List<RestaurantEntity> listRestaurant;

  GetListRestaurantLoadedState({this.listRestaurant});

  @override
  List<Object> get props => [listRestaurant];
}

class GetListRestaurantFailedState extends GetListRestaurantState {
  final String message;

  GetListRestaurantFailedState({this.message});

  @override
  List<Object> get props => [message];
}