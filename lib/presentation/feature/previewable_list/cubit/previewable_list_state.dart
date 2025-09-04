part of 'previewable_list_cubit.dart';

enum PreviewableType { issues, pullRequests }

abstract class PreviewableListState extends Equatable {
  const PreviewableListState();

  @override
  List<Object?> get props => [];
}

class PreviewableListInitial extends PreviewableListState {
  const PreviewableListInitial();
}

class PreviewableListLoading extends PreviewableListState {
  const PreviewableListLoading();
}

class PreviewableListSuccess extends PreviewableListState {
  const PreviewableListSuccess({
    required this.items,
    required this.type,
  });

  final List<Previewable> items;
  final PreviewableType type;

  @override
  List<Object?> get props => [items, type];
}

class PreviewableListError extends PreviewableListState {
  const PreviewableListError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
