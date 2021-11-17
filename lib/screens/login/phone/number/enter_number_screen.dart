import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';

class EnterNumberScreen extends StatefulWidget {
  static const routeName = '/enter_phone_number';

  const EnterNumberScreen({Key? key}) : super(key: key);

  @override
  _EnterNumberScreenState createState() => _EnterNumberScreenState();
}

class _EnterNumberScreenState extends State<EnterNumberScreen> {
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(),
            verifyingPhoneNumberIndicator(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              enterNumberText(),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  countryFlagImage(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: phoneNumberTextField(),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  youMayReceiveSMSText(),
                  const SizedBox(width: 20),
                  nextButton(),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget verifyingPhoneNumberIndicator() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const LinearProgressIndicator(
          backgroundColor: Colors.white,
          minHeight: 3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }

  Widget enterNumberText() {
    return Text(
      S.of(context).enterPhoneNumber,
      style: const TextStyle(fontSize: 22, color: Colors.black),
    );
  }

  Widget countryFlagImage() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/flags/gh.png',
              width: 35,
              height: 24,
              fit: BoxFit.cover,
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget phoneNumberTextField() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '+233',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: S.of(context).phoneNumberHint,
                hintStyle:
                TextStyle(fontSize: 18, color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              autofocus: true,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget youMayReceiveSMSText() {
    return Expanded(
      child: Text(
        S.of(context).youMayReceiveSMS,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
      ),
    );
  }

  Widget nextButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(height: 45, width: 120),
      child: ElevatedButton(
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).next, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward),
              ],
            ),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          )
    );
  }
}
