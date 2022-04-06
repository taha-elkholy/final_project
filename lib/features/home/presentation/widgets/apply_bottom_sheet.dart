import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:final_project/core/const/strings.dart';
import 'package:final_project/core/presentations/widgets/app_text_form_field.dart';
import 'package:final_project/di/injector/injector.dart';
import 'package:final_project/features/home/domain/entities/job.dart';
import 'package:final_project/features/home/presentation/bloc/apply_cubit/apply_cubit.dart';
import 'package:final_project/features/home/presentation/bloc/apply_cubit/apply_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyBottomSheet extends StatefulWidget {
  const ApplyBottomSheet({
    Key? key,
    required this.job,
  }) : super(key: key);

  final Job job;

  @override
  State<ApplyBottomSheet> createState() => _ApplyBottomSheetState();
}

class _ApplyBottomSheetState extends State<ApplyBottomSheet> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController currentSalaryController;

  late TextEditingController expectedSalaryController;

  @override
  void initState() {
    currentSalaryController = TextEditingController();
    expectedSalaryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    currentSalaryController.dispose();
    expectedSalaryController.dispose();
    super.dispose();
  }

  File? cv;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        cv = File(result.files.single.path!);
      });
    } else {
      debugPrint('user cancel file pick');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ApplyCubit>(),
      child: BlocConsumer<ApplyCubit, ApplyStates>(listener: (context, state) {
        if (state is ApplyErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Apply Error')));
        }
        if (state is ApplyLoadedState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('You Have Applied Successfully')));
        }
      }, builder: (context, state) {
        return Container(
          height: 400,
          padding: MediaQuery.of(context).viewInsets,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Apply for this Job',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                widget.job.name,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.job.description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                          controller: currentSalaryController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Current Salary';
                            }
                            return null;
                          },
                          inputType: TextInputType.number,
                          label: 'Current Salary'),
                      const SizedBox(
                        height: 8,
                      ),
                      AppTextFormField(
                          controller: expectedSalaryController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Expected Salary';
                            }
                            return null;
                          },
                          inputType: TextInputType.number,
                          label: 'Expected Salary'),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                pickFile();
                              },
                              child: const Text('attach'),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (cv != null) {
                                  if(formKey.currentState!.validate()){
                                    BlocProvider.of<ApplyCubit>(context).apply(
                                        jobId: widget.job.id,
                                        currentSalary: int.parse(
                                            currentSalaryController.text),
                                        expectedSalary: int.parse(
                                            expectedSalaryController.text),
                                        cv: cv!);
                                  }
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('You Must Upload CV')));
                                }
                              },
                              child: const Text(apply),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        );
      }),
    );
  }
}
