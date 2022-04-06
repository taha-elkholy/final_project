import 'dart:io';

import 'package:equatable/equatable.dart';

class ApplySentEntity extends Equatable {
  final int jobId;
  final int currentSalary;
  final int expectedSalary;
  final File cv;

  const ApplySentEntity({
    required this.jobId,
    required this.currentSalary,
    required this.expectedSalary,
    required this.cv,
  });

  @override
  List<Object?> get props => [
        jobId,
      ];
}
