import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, SelectContext;
import 'package:masrimanas_test/blocs/save_data/save_data_bloc.dart';
import 'package:masrimanas_test/ui/ui.dart';
import 'package:masrimanas_test/ui/widgets/custom_field.dart';

class SaveDataPage extends StatefulWidget {
  const SaveDataPage({super.key});

  static const route = '/save-data';

  @override
  State<SaveDataPage> createState() => _SaveDataPageState();
}

class _SaveDataPageState extends State<SaveDataPage> {
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _umurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((SaveDataBloc bloc) => bloc.state);
    if (state is SaveDataLoaded) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Nama: '),
                    Flexible(
                      child: CustomField(
                        controller: _namaController,
                        text: state.nama,
                        marginX: 10,
                        marginY: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Umur: '),
                    Flexible(
                      child: CustomField(
                        controller: _umurController,
                        text: state.umur,
                        type: TextInputType.number,
                        marginX: 10,
                        marginY: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 100),
                    Flexible(
                      child: CustomButton(
                        color: Colors.grey[600]!,
                        onPressed: () {
                          context.read<SaveDataBloc>().add(
                                SaveDataNew(
                                  nama: _namaController.text,
                                  umur: _umurController.text,
                                ),
                              );
                        },
                        text: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text(''),
        ),
      );
    }
  }
}
