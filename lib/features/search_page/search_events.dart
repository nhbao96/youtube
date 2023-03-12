import 'package:youtube_baonh/common/bases/base_event.dart';

class LoadRecommendKeywords extends BaseEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

  LoadRecommendKeywords();
}

class SearchWithKeywordEvent extends BaseEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

  String keyword;

  SearchWithKeywordEvent(this.keyword);
}

class AutoCompleteKeywordsEvent extends BaseEvent{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

  String keyword;

  AutoCompleteKeywordsEvent(this.keyword);
}