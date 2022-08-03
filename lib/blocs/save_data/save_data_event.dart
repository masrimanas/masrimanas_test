part of 'save_data_bloc.dart';

abstract class SaveDataEvent extends Equatable {
  const SaveDataEvent();

  @override
  List<Object> get props => [];
}

class SaveDataLoad extends SaveDataEvent {
  const SaveDataLoad();

  @override
  List<Object> get props => [];
}

class SaveDataNew extends SaveDataEvent {
  const SaveDataNew({
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
