import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../github_user.dart';
import '../api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GithubSearchEvent>(
      (event, emit) async {
        emit(Searching());

        try {
          final users = await Api.search(query: event.query);
          emit(SearchSuccess(users));
        } catch (e) {
          print('-- $e');
          emit(SearchFailed());
        }
      },
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 350))
            .asyncExpand(mapper);
      },
    );
  }
}
