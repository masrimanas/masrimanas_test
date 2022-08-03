part of 'save_data_bloc.dart';

abstract class SaveDataState extends Equatable {
  const SaveDataState();

  @override
  List<Object> get props => [];
}

class SaveDataInitial extends SaveDataState {
  const SaveDataInitial({
    required this.nama,
    required this.umur,
  });

  final String nama;
  final String umur;
  @override
  List<Object> get props => [
        nama,
        umur,
      ];
}

class SaveDataLoaded extends SaveDataState {
  const SaveDataLoaded({
    required this.nama,
    required this.umur,
  });

  final String nama;
  final String umur;
  @override
  List<Object> get props => [
        nama,
        umur,
      ];
}
