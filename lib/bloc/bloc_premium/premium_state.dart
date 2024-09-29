
part of 'premium_bloc.dart';

class PremiumState {}

class LoadPremiumState extends PremiumState {}

class SuccessPremiumState extends PremiumState {
  List<Matches>? resMatches;
  List<UnmatchedUsers>? resEnigmatic;
  ModelCreatePayment? responsePayment;

  SuccessPremiumState({this.resMatches, this.resEnigmatic, this.responsePayment});
}