import 'dart:io';

import 'package:final_project/features/home/domain/entities/apply_sent_entity.dart';
import 'package:final_project/features/home/domain/use_case/apply_use_case.dart';
import 'package:final_project/features/home/presentation/bloc/apply_cubit/apply_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyCubit extends Cubit<ApplyStates> {
  final ApplyUseCase _applyUseCase;

  ApplyCubit(this._applyUseCase) : super(const ApplyInitialState());

  Future<void> apply({
    required int jobId,
    required int currentSalary,
    required int expectedSalary,
    required File cv,
  }) async {
    emit(const ApplyLoadingState());
    final _data = ApplySentEntity(
        jobId: jobId,
        currentSalary: currentSalary,
        expectedSalary: expectedSalary,
        cv: cv);
    final result = await _applyUseCase.call(_data);

    emit(result.fold((error) {
      if (kDebugMode) {
        print(error.message);
      }
      return ApplyErrorState(error: error.message);
    }, (done) {
      return const ApplyLoadedState();
    }));
  }
}
