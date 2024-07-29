import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jogjasport/models/user_models.dart';
import 'package:jogjasport/providers/auth_provider.dart';
import 'package:jogjasport/theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController addressController;
  TextEditingController phoneController;
  bool isLoading = false;

  @override
  @override
  void initState() {
    super.initState();
    isLoading = false;
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final UserModel user = authProvider.user;

    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    addressController = TextEditingController(text: user.address);
    phoneController = TextEditingController(text: user.phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    handleUpdateProfile() async {
      setState(() {
        isLoading = true;
      });
      try {
        await authProvider.updateProfile(
          name: nameController.text,
          email: emailController.text,
          address: addressController.text,
          phone: phoneController.text,
          token: user.token,
        );
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: primaryColor,
          content: const Text(
            'Berhasil Update Profile, silahkan login kembali',
            textAlign: TextAlign.center,
          ),
        ));
        setState(() {});
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: alertColor,
          content: Text(
            e.toString(),
            textAlign: TextAlign.center,
          ),
        ));
      }
    }

    Widget header(BuildContext context) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bgColor1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
            onPressed: handleUpdateProfile,
          ),
        ],
      );
    }

    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
              style: secondarytextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: nameController,
              style: primarytextStyle,
              decoration: InputDecoration(
                hintText: 'Input nama',
                hintStyle: primarytextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget addressInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat Rumah',
              style: secondarytextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: addressController,
              style: primarytextStyle,
              decoration: InputDecoration(
                hintText: 'Input alamat',
                hintStyle: primarytextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor HP',
              style: secondarytextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: phoneController,
              style: primarytextStyle,
              decoration: InputDecoration(
                hintText: 'Input nomor HP',
                hintStyle: primarytextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat Email',
              style: secondarytextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: emailController,
              style: primarytextStyle,
              decoration: InputDecoration(
                hintText: 'Input email',
                hintStyle: primarytextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    '${user.profilePhotoUrl}&size=512',
                  ),
                ),
              ),
            ),
            nameInput(),
            addressInput(),
            phoneInput(),
            emailInput(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: header(context),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(child: content()),
      resizeToAvoidBottomInset: true,
    );
  }
}
