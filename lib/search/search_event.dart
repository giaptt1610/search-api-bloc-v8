part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class GithubSearchEvent extends SearchEvent {
  final String query;
  GithubSearchEvent(this.query);
}
