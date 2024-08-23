
part of 'premium_bloc.dart';

class PremiumEvent {}

class LoadPremiumEvent extends PremiumEvent {}

class SuccessPremiumEvent extends PremiumEvent {
  List<Matches>? resMatches;
  List<UnmatchedUsers>? resEnigmatic;

  SuccessPremiumEvent({this.resMatches, this.resEnigmatic});
}