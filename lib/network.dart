import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:linkedin/linked_in_user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Network {
  static String? linkedinAuthCode =
      'AQXAxXOByn6Y-RCzL-vidppxeD-3hrh6LIlXfqn-uET7rnoI6ySFfx7XnZen0ir5ztanxnUrbkwMI41McN7UO6o387xRpGU6AFR45sHj23uw8oBmlCr5XvHGJx5hlaLijg1W1VoSfYt-R8Kmm7GhB-qYZ_DzSqACVdxvxRn57Qc6bl7KFs-YgIngmgk4nuOD4bLXyARgmcewEwwliLvz_QL12oCvFFrfS3EQw6Uucus0HExoi4HrVjbCTpGhfFpSxeTU7TDn5vUZbZb-rTAW5X4e33-LsfFZ5KLxxqnKgv7KQvkm13oQ3Anf4p3W8OyJnMCqjhXkrEhP78UrNGf_aCH7M99f4A';
  static final String callbackUrl = 'http://localhost:5000/linkedinauth';

  static final String clientId = '86aq5lrpzyiroa';

  static final String clientSecret = 'OihZwxlKBFV8j6H8';

  static Future signinWithLinkedIn() async {
    try {
      await Network.signInLinkedIn();
      await Network.getLinkedinAuthCode(
          'AQRYgdGv1UL5oy0Qzqg-SWf7tZOzTGiDf_-RlWGAQ7UuI42LnDSi4iLK02O3_y847vPG8CAQz2HIoloCflsiXiWNW3D6vdiOmK4OXsiaAW2AJn3uyNjjEElPkSnIph6fnh6xsfCnA4Ezd0cgrJOHXZ4VrugHHk49xmoiXUjzBUZDWUWRCsXxxd44Ao_O26IPgvexxwoOhdQ2zaMDxz8');
      var userResponse = await Network.readLinkedinUser();
      print('The user response is $userResponse');
    } catch (e, s) {
      print('Error is $e and the stack trace is $s');
    }
  }

  static Future signInLinkedIn() async {
    // TODO: w_member_social This access is used to share the post on linkedin
    return _launchUrl(
      'https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=$clientId&redirect_uri=$callbackUrl&state=temperbor&scope=r_liteprofile%20r_emailaddress%20w_member_social',
    );
  }

  static Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url), webOnlyWindowName: '_self'
        // open the url in the same page

        // webViewConfiguration: WebViewConfiguration(),
        )) {
      throw 'Could not launch $_url';
    }
  }

  static Future<LinkedinUser> readLinkedinUser() async => await handleResponse(
        await http.get(
          Uri.parse('https://api.linkedin.com/v2/me'),

          headers: {
            // 'Content-Type': 'application/x-www-form-urlencoded',
            // 'Accept': '*/*',
            'Authorization': 'Bearer ${Network.linkedinAuthCode}'
          },
          // ).timeout(timeOutDuration);// await
          // buildHttpResponse(
          //   method: HttpMethod.get,
          // ),
        ),
      ).then(
        (value) {
          print('The linked in user response is $value');
          return LinkedinUser.fromMap(value);
        },
      );

  // static Future<bool> checkIfUserExists(String userId) {}

  static Future<String?> getLinkedinAuthCode(String accessCode) async {
    if (linkedinAuthCode != null && linkedinAuthCode!.isNotEmpty) {
      return Future.value(linkedinAuthCode);
    }
    Future<http.Response> returnResponse() async {
      print('Within the response field');
      try {
        return await http.post(
          Uri.parse(
            'https://www.linkedin.com/oauth/v2/accessToken',
          ),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'grant_type': 'authorization_code',
            'code': accessCode,
            'client_id': clientId,
            'client_secret': clientSecret,
            'redirect_uri': callbackUrl,
          },
        );
      } catch (e, stackTarce) {
        print('The error is $e with stacktrace $stackTarce');
        return http.Response('Dummy Response', 500);
      }
    }

    return await returnResponse().then(
      (value) {
        print(
            'The linked in status code is ${value.statusCode.toString()} with body data ${value.body.toString()}');
        return json.decode(value.body)['access_token'];
      },
    );
  }

  static Future handleResponse(Response response) async {
    print(
        'Entered into handle response with status code ${response.statusCode}');
    bool isSuccessful(int value) => value >= 200 && value <= 206;

    try {
      if (response.statusCode == 401) {
        // await LocalData.putRefreshToken(value: null);
      }
      if (isSuccessful(response.statusCode)) {
        print('Successful');

        if (response.statusCode == 204) {
          print('204');
          return [];
        } else {
          print(
              'The Response code is ${response.statusCode} with with return type ${json.decode(response.body).runtimeType} the response} ');
          return json.decode(response.body);
        }
      } else {
        print(response.statusCode);
        print(response.body);
        throw 'The Function for JSON encode';
      }
    } on TimeoutException {
      // ErrorMessage = 'Client Timeout';
      throw 'Client Timeout';
    } on HandshakeException {
      // ErrorMessage = 'Handshake Exception';
      throw 'Handshake Exception';
    } catch (e) {
      print(e);
      // ErrorMessage = json.decode(response.body)['message'];

      rethrow;
    }
  }
}
