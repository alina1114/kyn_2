import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/core/common/error_text.dart';
import 'package:kyn_2/core/common/loader.dart';
import 'package:kyn_2/core/theme/pallete.dart';
import 'package:kyn_2/core/utils.dart';
import 'package:kyn_2/features/whatshot/community/controller/community_controller.dart';
import 'package:kyn_2/features/whatshot/post/controller/post_controller.dart';
import 'package:kyn_2/models/community_model.dart';

class AddPostTypeScreen extends ConsumerStatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const AddPostTypeScreen(),
      );
  const AddPostTypeScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPostTypeScreenState();
}

class _AddPostTypeScreenState extends ConsumerState<AddPostTypeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  File? bannerFile;

  List<Community> communities = [];
  Community? selectedCommunity;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
  }

  void selectBannerImage() async {
    final res = await pickImage(false, 16, 9);

    if (res != null) {
      setState(() {
        bannerFile = res;
      });
    }
  }

  void sharePost() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty) {
      showSnackBar(context, 'Please enter the title');
      return;
    }

    ref.read(postControllerProvider.notifier).sharePost(
          context: context,
          title: title,
          description: description,
          file: bannerFile,
        );
  }

  @override
  Widget build(BuildContext context) {
    // final currentTheme = ref.watch(themeNotifierProvider);
    final isLoading = ref.watch(postControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: sharePost,
            child: const Text('Share'),
          ),
        ],
      ),
      body: isLoading
          ? Loader(
              color: Colors.red,
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Enter Title here',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(18),
                    ),
                    maxLength: 30,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Enter description here',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(18),
                    ),
                    maxLength: 150,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: selectBannerImage,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      color: AppPallete.borderColor,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: bannerFile == null
                            ? const Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 40,
                                ),
                              )
                            : Image.file(
                                bannerFile!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
