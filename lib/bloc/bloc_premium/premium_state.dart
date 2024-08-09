
part of 'premium_bloc.dart';

class PremiumState {}

class LoadPremiumState extends PremiumState {}

class SuccessPremiumState extends PremiumState {
  List<Matches> response;

  SuccessPremiumState({required this.response});
}