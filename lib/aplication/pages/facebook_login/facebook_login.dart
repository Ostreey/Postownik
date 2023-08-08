import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class FacebookLogin extends StatefulWidget {
  const FacebookLogin({Key? key}) : super(key: key);

  @override
  State<FacebookLogin> createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfisLoggedIn();
  }

  _checkIfisLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;

    } else {
      print(result.status);
      print(result.message);

    }
    setState(() {
      _checking = false;
    });
  }

  _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(_userData);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Facebook Auth Project')),
        body: _checking
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _userData != null
                    ? Text('name: ${_userData!['name']}')
                    : Container(),
                _userData != null
                    ? Text('email: ${_userData!['email']}')
                    : Container(),
                _userData != null
                    ? Container(
                  child: Image.network(
                      _userData!['picture']['data']['url']),
                )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(color: Colors.blue,
                    child: Text(
                      _userData != null ? 'LOGOUT' : 'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _userData != null ? _logout : _login),
                ElevatedButton(onPressed: () async{
                  final String url = 'https://graph.facebook.com/me/feed';
                  final Map<String, String> headers = {
                    'Content-Type': 'application/json',
                  };
                  print(" access: ${_accessToken?.token}");
                  final Map<String, dynamic> postData = {
                    'message': 'Hello, this is a test post from my Flutter app!',
                    'access_token': _accessToken?.token,
                  };

                  final http.Response response = await http.post(
                    Uri.parse(url),
                    headers: headers,
                    body: json.encode(postData),
                  );

                  if (response.statusCode == 200) {
                    print('Post shared successfully!');
                  } else {
                    print('Failed to share post. Status code: ${response.statusCode}');
                    print('Response body: ${response.body}');
                  }
                }, child: Text("Share")),


              ],
            )),
      ),
    );
  }
}