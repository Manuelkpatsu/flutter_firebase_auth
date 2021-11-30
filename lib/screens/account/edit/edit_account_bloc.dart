import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';
import 'package:flutterfirebaseauth/repository/user_repository.dart';
import 'package:flutterfirebaseauth/screens/account/email/update_email_argument.dart';
import 'package:flutterfirebaseauth/screens/account/name/update_name_argument.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../account_flow_coordinator.dart';
import 'edit_account_event.dart';
import 'edit_account_model_data.dart';

class EditAccountBloc extends ValueNotifier<EditAccountModelData> {
  final _logger = Logger();
  final _imagePicker = ImagePicker();
  final _eventController = StreamController<EditAccountEvent>.broadcast();

  final UserRepository _userRepository;
  final AccountFlowCoordinator _accountFlowCoordinator;

  EditAccountBloc(this._userRepository, this._accountFlowCoordinator)
      : super(const EditAccountModelData());

  void init() {
    _userRepository
        .userChanges()
        .listen((user) => _refreshUI(user))
        .onError((error) {
      _logger.e('Error updating user info', error);
    });

    getEventStream<EditAccountBlocEvent>()
        .listen((event) => _handleEvent(event))
        .onError((error) {
      _logger.e('Error responding to edit account notifier event', error);
    });
  }

  /// Gets the event stream for the subtype [T]
  Stream<T> getEventStream<T extends EditAccountEvent>() {
    return _eventController.stream
        .where((event) => event is T)
        .map((event) => event as T);
  }

  /// Adds event to the stream
  ///
  /// [T] the event subtype of [E]
  void addEvent<T extends EditAccountEvent>(T event) {
    _eventController.add(event);
  }

  /// Handles [EditAccountBlocEvent]s
  void _handleEvent(EditAccountBlocEvent event) {
    switch (event.runtimeType) {
      case SelectImageEvent:
        final selectImageEvent = event as SelectImageEvent;
        _updateUserPhoto(selectImageEvent.source);
        _accountFlowCoordinator.closeSelectImageDialog();
        break;
      case GoToUpdateNameEvent:
        final updateNameEvent = event as GoToUpdateNameEvent;
        final argument = UpdateNameArgument(updateNameEvent.name);
        _accountFlowCoordinator.goToUpdateNameScreen(argument);
        break;
      case GoToUpdateEmailEvent:
        final updateEmailEvent = event as GoToUpdateEmailEvent;
        final updateEmailArgument = UpdateEmailArgument(updateEmailEvent.email);
        _accountFlowCoordinator.goToUpdateEmailScreen(updateEmailArgument);
        break;
    }
  }

  /// Updates the user
  ///
  /// [user] the user to update to
  void _refreshUI(User? user) {
    if (user != null) {
      value = value.copyWith(
          photoURL: user.photoURL,
          displayName: user.displayName,
          phoneNumber: user.phoneNumber,
          email: user.email,
          emailVerified: user.emailVerified);
    } else {
      _logger.w('User is not signed in');
    }
  }

  /// Updates the user's photo
  ///
  /// [imageSource] image selection source
  void _updateUserPhoto(ImageSource imageSource) {
    _selectImage(imageSource)
        .then((selectedImage) => _cropImage(selectedImage))
        .then((croppedImage) {
      if (croppedImage == null) {
        _logger.d('No image selected');
        return;
      }

      _uploadImage(croppedImage)
          .then((uploadedPhotoURL) => _updateImage(uploadedPhotoURL))
          .whenComplete(() {
        addEvent(ShowSnackBarEvent(S.current.photoUpdated));
      }).catchError((error) {
        _logger.e('Error updating user photo', error);
        addEvent(ShowSnackBarEvent(S.current.photoUpdateFailed));
      });
    });
  }

  /// Selects the image
  ///
  /// [imageSource] image selection source
  Future<File?> _selectImage(ImageSource imageSource) {
    _logger.i('Picking image');
    return _imagePicker
        .pickImage(source: imageSource)
        .then((xFile) => xFile == null ? null : File(xFile.path));
  }

  /// Crops the selected image
  ///
  /// [selectedImage] selected image
  Future<File?> _cropImage(File? selectedImage) {
    if (selectedImage == null) {
      return Future.value(null);
    }

    _logger.i('Cropping image');

    return ImageCropper.cropImage(
      sourcePath: selectedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      maxWidth: 400,
      maxHeight: 400,
      compressFormat: ImageCompressFormat.png,
      cropStyle: CropStyle.circle,
      androidUiSettings: AndroidUiSettings(
          toolbarWidgetColor: Colors.white,
          toolbarColor: Colors.black,
          toolbarTitle: S.current.cropImage,
          statusBarColor: Colors.black,
          backgroundColor: Colors.white,
          hideBottomControls: true,
          showCropGrid: false,
          cropFrameColor: Colors.transparent
      ),
      // TODO iOS UI settings
    );
  }

  /// Uploads user's profile photo
  ///
  /// [image] image file to upload
  Future<String> _uploadImage(File image) {
    final uploadTaskFuture = _userRepository.getUploadImageTask(image);

    return uploadTaskFuture.then((uploadTask) {
      uploadTask.snapshotEvents.listen((snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        _logger.i(
          'Uploading image... '
              'progress = $progress, '
              'transferred = ${snapshot.bytesTransferred}, '
              'total = ${snapshot.totalBytes}',
        );
        value = value.copyWith(uploadProgress: progress);
      });

      return uploadTask
          .then((snapshot) => snapshot.ref.getDownloadURL().then((url) => url))
          .whenComplete(() {
        _logger.i('Upload complete');
        value.copyWith(uploadProgress: null);
      });
    });
  }

  /// Updates user's profile photo
  ///
  /// [photoURL] photo URL
  Future<void> _updateImage(String photoURL) {
    _logger.i('Updating user image');
    return _userRepository.updateProfilePhoto(photoURL);
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
