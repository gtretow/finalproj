// ignore_for_file: no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:myfinalapp/Model/person_model.dart';
import 'package:myfinalapp/Repository/Person_repository.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:path/path.dart';

class AddPersonScreen extends StatefulWidget {
  const AddPersonScreen({super.key});

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  PersonBack4AppRepository personRepo = PersonBack4AppRepository();

  String imagePath = '';
  XFile? pickedFile;

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      pickedFile = XFile(croppedFile.path);
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      String path =
          (await path_provider.getApplicationDocumentsDirectory()).path;
      String name = basename(pickedFile!.path);
      await pickedFile!.saveTo("$path/$name");

      await GallerySaver.saveImage(pickedFile!.path);

      setState(() {
        imagePath = pickedFile!.path;
      });
      cropImage(pickedFile!);
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await personRepo.createPerson(PersonModel.create(
          nameController.text, imagePath, addressController.text));

      nameController.clear();
      addressController.clear();
      setState(() {
        imagePath = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nome é obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Endereço'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Endereço é obrigatório';
                }
                return null;
              },
            ),
            if (imagePath.isNotEmpty)
              Image.file(
                File(imagePath),
                height: 150,
              ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const AutoSizeText(
                'Escolher Imagem',
                maxLines: 1,
                maxFontSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const AutoSizeText(
                'Cadastrar Pessoa',
                maxLines: 1,
                maxFontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
