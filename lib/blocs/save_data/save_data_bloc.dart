import 'package:bloc/bloc.dart' show Bloc, Emitter;
import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;
import 'package:equatable/equatable.dart' show Equatable;

import 'package:masrimanas_test/data/data.dart';

part 'save_data_event.dart';
part 'save_data_state.dart';

class SaveDataBloc extends Bloc<SaveDataEvent, SaveDataState> {
  SaveDataBloc(
    this._repo,
  ) : super(const SaveDataInitial(nama: '', umur: '')) {
    on<SaveDataLoad>(_loadData, transformer: sequential());
    on<SaveDataNew>(_newData, transformer: sequential());
  }

  final DataRepository _repo;

  Future<void> _loadData(
    SaveDataLoad event,
    Emitter<SaveDataState> emit,
  ) async {
    final result = await _repo.getData();
    result.fold(
      (failure) => emit(
        const SaveDataLoaded(nama: '', umur: ''),
      ),
      (data) => emit(
        SaveDataLoaded(nama: data[0], umur: data[1]),
      ),
    );
  }

  Future<void> _newData(
    SaveDataNew event,
    Emitter<SaveDataState> emit,
  ) async {
    final result = await _repo.saveData(event.nama, event.umur);
    result.fold(
      (failure) => null,
      (data) => emit(
        SaveDataLoaded(nama: event.nama, umur: event.umur),
      ),
    );
  }
}
