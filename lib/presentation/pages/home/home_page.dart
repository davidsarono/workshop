import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/presentation/pages/home/bloc/home_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.poem != current.poem || previous.status != current.status,
        builder: (context, state) {
          if (state.status == HomeStatus.loading && state.poem == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.poem == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _openGallery(context);
                    },
                    child: const Text('Generate Poem from Gallery'),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Text(
              state.poem!,
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeBloc>().add(const ResetPoem());
        },
        child: const Icon(Icons.refresh),
      )
    );
  }

  void _openGallery(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    _picker.pickImage(source: ImageSource.gallery).then((XFile? image) {
      if (image != null) {
        context.read<HomeBloc>().add(GeneratePoem(image: File(image.path)));
      }
    }).catchError((error) {
      debugPrint('Error: $error');
    });
  }
}
