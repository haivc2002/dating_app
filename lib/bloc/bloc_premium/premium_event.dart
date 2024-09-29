
part of 'premium_bloc.dart';

class PremiumEvent {}

class LoadPremiumEvent extends PremiumEvent {}

class SuccessPremiumEvent extends PremiumEvent {
  List<Matches>? resMatches;
  List<UnmatchedUsers>? resEnigmatic;
  ModelCreatePayment? responsePayment;

  SuccessPremiumEvent({this.resMatches, this.resEnigmatic, this.responsePayment});
}