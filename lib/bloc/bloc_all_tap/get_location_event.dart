
part of 'get_location_bloc.dart';

class GetLocationEvent {}

class LoadGetLocationEvent extends GetLocationEvent {}

class SuccessGetLocationEvent extends GetLocationEvent {
  List<Results> response;

  SuccessGetLocationEvent(this.response);
}