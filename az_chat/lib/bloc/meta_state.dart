part of 'meta_bloc.dart';

class MetaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MetaLoadProgress extends MetaState {}
class MetaLoadFailed extends MetaState {}
class MetaLoadSuccess extends MetaState {
  LinkMetaData metaData;
  MetaLoadSuccess(this.metaData);
  @override
  List<Object?> get props => [
    metaData,
  ];
}