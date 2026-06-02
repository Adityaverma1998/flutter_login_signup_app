import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required Function(ImageSource source) onSelect,
  }) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Profile Image',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 20.h),

                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);

                    onSelect(ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);

                    onSelect(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
