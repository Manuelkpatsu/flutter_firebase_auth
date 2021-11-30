import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';
import 'package:flutterfirebaseauth/widgets/non_editable_text_field.dart';

import 'edit_account_bloc.dart';
import 'edit_account_listenable.dart';
import 'edit_account_event.dart';

class EditAccountBuilder extends StatelessWidget {
  final EditAccountBloc bloc;

  const EditAccountBuilder(this.bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  thumbnailImage(),
                  imageUploadProgressIndicator(),
                  selectImageButton(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            fullNameText(),
            const SizedBox(height: 5),
            fullNameTextField(),
            const SizedBox(height: 20),
            phoneNumberText(),
            const SizedBox(height: 5),
            phoneNumberTextField(),
            const SizedBox(height: 20),
            emailAddressText(),
            const SizedBox(height: 5),
            emailAddressTextField(),
            const SizedBox(height: 30),
            logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget verifyingPhoneNumberIndicator(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ValueListenableBuilder<bool>(
          valueListenable: bloc.progressIndicator,
          child: const LinearProgressIndicator(
            backgroundColor: Colors.white,
            minHeight: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          builder: (context, showProgress, child) {
            return Visibility(
              visible: showProgress,
              child: child!,
            );
          },
        ),
      ),
    );
  }

  Widget titleText() {
    return const Text('Account', style: TextStyle(fontSize: 22, color: Colors.black));
  }

  Widget thumbnailImage() {
    return ValueListenableBuilder<String?>(
      valueListenable: bloc.accountImage,
      builder: (context, photoURL, child) {
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () {
              bloc.addEvent(ShowSelectImageOptionsSheetEvent());
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: photoURL == null
                  ? Image.asset(
                      'assets/images/profile_image_placeholder.png',
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const ExactAssetImage(
                        'assets/images/profile_image_placeholder.png',
                      ),
                      image: NetworkImage(photoURL),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/profile_image_placeholder.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget imageUploadProgressIndicator() {
    return ValueListenableBuilder<double?>(
      valueListenable: bloc.imageUploadProgressIndicator,
      builder: (context, uploadProgress, child) {
        return Visibility(
          visible: uploadProgress != null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 96,
                height: 96,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: const AlwaysStoppedAnimation(Colors.black),
                  value: uploadProgress,
                ),
              ),
              Text(
                '${(uploadProgress == null ? 0 : uploadProgress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(15, 15),
                      blurRadius: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget selectImageButton() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          bloc.addEvent(ShowSelectImageOptionsSheetEvent());
        },
        child: const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 16,
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
      ),
    );
  }

  Widget fullNameText() {
    return Text(
      S.current.fullName.toUpperCase(),
      style: const TextStyle(color: Colors.black54),
    );
  }

  Widget fullNameTextField() {
    String? name;
    return NonEditableTextField(
      onPressed: () {
        bloc.addEvent(GoToUpdateNameEvent(name ?? ''));
      },
      child: ValueListenableBuilder<String?>(
        valueListenable: bloc.fullNameTextField,
        builder: (context, fullName, child) {
          name = fullName;
          return Text(
            fullName ?? '',
            style: const TextStyle(color: Colors.black, fontSize: 16),
          );
        },
      ),
    );
  }

  Widget phoneNumberText() {
    return Text(
      S.current.phoneNumber.toUpperCase(),
      style: const TextStyle(color: Colors.black54),
    );
  }

  Widget phoneNumberTextField() {
    return NonEditableTextField(
      onPressed: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ValueListenableBuilder<String?>(
              valueListenable: bloc.phoneNumberTextField,
              builder: (context, phoneNumber, child) {
                return Text(
                  phoneNumber ?? '',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.check_circle, color: Colors.black, size: 20)
        ],
      ),
    );
  }

  Widget emailAddressText() {
    return Text(
      S.current.emailAddress.toUpperCase(),
      style: const TextStyle(color: Colors.black54),
    );
  }

  Widget emailAddressTextField() {
    String? email;
    return NonEditableTextField(
      onPressed: () {
        bloc.addEvent(GoToUpdateEmailEvent(email));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ValueListenableBuilder<String?>(
              valueListenable: bloc.emailAddressTextField,
              builder: (context, emailAddress, child) {
                email = emailAddress;
                return Text(
                  email ?? '',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          ValueListenableBuilder<bool>(
            valueListenable: bloc.isEmailVerified,
            builder: (context, emailVerified, child) {
              return Visibility(
                visible: emailVerified,
                child: const Icon(Icons.check_circle, color: Colors.black, size: 20),
              );
            },
          )
        ],
      ),
    );
  }

  Widget logoutButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 45, width: 120),
        child: ValueListenableBuilder<bool>(
          valueListenable: bloc.logoutButton,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout),
              const SizedBox(width: 10),
              Text(
                S.current.logout,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          builder: (context, enableButton, child) {
            return ElevatedButton(
              onPressed: enableButton ? () => bloc.addEvent(LogoutEvent()) : null,
              child: child,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
            );
          },
        ),
      ),
    );
  }
}
