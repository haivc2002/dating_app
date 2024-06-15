
part of 'get_location_bloc.dart';

class GetLocationState {}

class LoadGetLocationState extends GetLocationState {}

class SuccessGetLocationState extends GetLocationState {
  List<Results> response;

  SuccessGetLocationState({required this.response});
}