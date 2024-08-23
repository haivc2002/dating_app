
part of 'premium_bloc.dart';

class PremiumState {}

class LoadPremiumState extends PremiumState {}

class SuccessPremiumState extends PremiumState {
  List<Matches>? resMatches;
  List<UnmatchedUsers>? resEnigmatic;

  SuccessPremiumState({this.resMatches, this.resEnigmatic});
}