import 'dart:convert';
import 'package:dentist_dashboard/constants.dart';
import 'package:http_parser/http_parser.dart';
import 'package:universal_io/io.dart';
import 'dart:js' as js;
import 'dart:typed_data';
import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:path/path.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class RemoteServices {
  static const String _hostIP = "$kHostIP/api";
  static http.Client client = http.Client();
  static String get token => html.window.localStorage["token"] ?? "no token";

  /// auth requests

  static Future<String?> register(
    String email,
    String password,
    String rePassword,
    String name,
    String phone,
    String secret,
  ) async {
    var response = await client.post(
      Uri.parse("$_hostIP/register-admin"),
      body: jsonEncode({
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "secret": secret,
        "password_confirmation": rePassword,
      }),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)["access_token"];
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  //todo: don't let users login to dashboard
  //todo: handle session expiration
  static Future<String?> login(String email, String password) async {
    var response = await client.post(
      Uri.parse("$_hostIP/login"),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      String accessToken = jsonDecode(response.body)["access_token"];
      if (jsonDecode(response.body)["role"] != "admin") {
        js.context.callMethod('alert', ["dashboard is only for admins"]);
        //todo: log user out (revoke token)
        return null;
      }
      return accessToken;
    } else {
      //js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> logout() async {
    var response = await client.get(
      Uri.parse("$_hostIP/logout"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  /// otp requests

  static Future<String?> sendRegisterOtp() async {
    var response = await client.get(
      Uri.parse("$_hostIP/send-register-otp"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)["url"];
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> verifyRegisterOtp(String otp, String url) async {
    var response = await client.post(
      Uri.parse(url),
      body: jsonEncode({
        'otp': otp,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  static Future<bool> sendForgotPasswordOtp(String email) async {
    var response = await client.post(
      Uri.parse('$_hostIP/send-reset-otp'),
      body: jsonEncode({
        'email': email,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  static Future<String?> verifyForgotPasswordOtp(String email, String otp) async {
    var response = await client.post(
      Uri.parse('$_hostIP/verify-reset-otp'),
      body: jsonEncode({
        'email': email,
        'otp': otp,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)["reset_token"];
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> resetPassword(String email, String password, String rePassword, String resetToken) async {
    var response = await client.post(Uri.parse('$_hostIP/reset-password'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'password_confirmation': rePassword,
          'token': resetToken,
        }),
        headers: {
          'Content-Type': 'application/json',
          "Accept": 'application/json',
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  /// profile requests

  static Future<bool> uploadProfileImage(File? imageFile) async {
    var request = http.MultipartRequest("POST", Uri.parse("$_hostIP/upload-profile-image"));
    request.headers['Authorization'] = "Bearer $token";
    request.headers['Accept'] = 'application/json';
    var stream = http.ByteStream(imageFile!.openRead());
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: basename(imageFile.path),
    );

    request.files.add(multipartFile);

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('error massage: $responseBody');
      return false;
    }
  }

  static Future<UserModel?> fetchCurrentUser() async {
    var response = await client.get(
      Uri.parse("$_hostIP/profile"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    //print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> editProfile(String name, String phone) async {
    var response = await client.post(
      Uri.parse('$_hostIP/edit-profile'),
      body: jsonEncode({
        'name': name,
        'phone': phone,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return false;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  static Future<bool> editPassword(String newPassword, String currentPassword) async {
    var response = await client.post(
      Uri.parse('$_hostIP/edit-password'),
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return false;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  //todo: add delete account
  static Future<bool> deleteUser(int id) async {
    var response = await client.delete(
      Uri.parse('$_hostIP/users'),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return false;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  /// brand requests

  static Future<List<BrandModel>?> fetchAllBrands() async {
    var response = await client.get(
      Uri.parse("$_hostIP/brands"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return brandModelFromJson(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<BrandModel?> fetchBrand(int id) async {
    var response = await client.get(
      Uri.parse("$_hostIP/brands/$id"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return BrandModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<List<BrandModel>?> searchBrands(String query) async {
    var response = await client.get(
      Uri.parse("$_hostIP/brands/search/$query"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return brandModelFromJson(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<List<ProductModel>?> fetchProductsFromBrand(int id) async {
    var response = await client.get(
      Uri.parse("$_hostIP/brand-products/$id"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return productModelFromJson(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> createBrand(Uint8List imageBytes, String brandTitle) async {
    var request = http.MultipartRequest("POST", Uri.parse("$_hostIP/brands"));
    Map<String, String> headers = {
      'Authorization': "Bearer $token",
      'Accept': 'Application/Json',
      //'Content-Type': 'application/json; charset=utf-8',
    };

    request.headers.addAll(headers);

    request.fields.addAll({
      'title': brandTitle,
    });

    var multipartFile = http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'image.jpg',
      contentType: MediaType('application', 'json'),
    );

    request.files.add(multipartFile);

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(responseBody)['message']]);
      print('error message: $responseBody');
      return false;
    }
  }

  static Future<bool> updateBrand(Uint8List? imageBytes, String brandTitle, int id) async {
    var request = http.MultipartRequest("POST", Uri.parse("$_hostIP/brands/$id?_method=PATCH"));

    Map<String, String> headers = {
      'Authorization': "Bearer $token",
      'Accept': 'Application/Json',
      //'Content-Type': 'application/json; charset=utf-8',
    };

    request.headers.addAll(headers);

    request.fields.addAll({
      'title': brandTitle,
    });

    if (imageBytes != null) {
      var multipartFile = http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.jpg',
        contentType: MediaType('application', 'json'), // Modify the content type based on your image format
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      js.context.callMethod('alert', [jsonDecode(responseBody)['message']]);
      print('error message: ${jsonDecode(responseBody)}');
      return false;
    }
  }

  static Future<bool> deleteBrand(int id) async {
    var response = await client.delete(
      Uri.parse('$_hostIP/brands/$id'),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return false;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  /// products requests

  //todo: products rows
  //todo: product body
  // static Future<bool> createProduct(List<File?> imageFile, String brandTitle) async {
  //   var request = http.MultipartRequest("POST", Uri.parse("$_hostIP/products"));
  //   request.headers['Authorization'] = "Bearer $token";
  //   request.headers['Accept'] = 'application/json';
  //   var stream = http.ByteStream(imageFile!.openRead());
  //   var length = await imageFile.length();
  //   var multipartFile = http.MultipartFile(
  //     'image',
  //     stream,
  //     length,
  //     filename: basename(imageFile.path),
  //   );
  //   request.fields.addAll({
  //     'title': brandTitle,
  //   });
  //   request.files.add(multipartFile);
  //
  //   var response = await request.send();
  //   var responseBody = await response.stream.bytesToString();
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return true;
  //   } else {
  //     js.context.callMethod('alert', [jsonDecode(responseBody)]);
  //     print('error message: $responseBody');
  //     return false;
  //   }
  // }
  //
  // static Future<bool> updateProduct(List<File?> imageFile, String brandTitle) async {
  //   // todo: check what happens when null is sent
  //   var request = http.MultipartRequest("PATCH", Uri.parse("$_hostIP/products"));
  //   request.headers['Authorization'] = "Bearer $token";
  //   request.headers['Accept'] = 'application/json';
  //   var stream = http.ByteStream(imageFile!.openRead());
  //   var length = await imageFile.length();
  //   var multipartFile = http.MultipartFile(
  //     'image',
  //     stream,
  //     length,
  //     filename: basename(imageFile.path),
  //   );
  //   request.fields.addAll({
  //     'title': brandTitle,
  //   });
  //   request.files.add(multipartFile);
  //
  //   var response = await request.send();
  //   var responseBody = await response.stream.bytesToString();
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return true;
  //   } else {
  //     js.context.callMethod('alert', [jsonDecode(responseBody)]);
  //     print('error message: $responseBody');
  //     return false;
  //   }
  // }

  static Future<List<ProductModel>?> fetchAllProducts() async {
    var response = await client.get(
      Uri.parse("$_hostIP/products"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return productModelFromJson(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<ProductModel?> fetchProduct(int id) async {
    var response = await client.get(
      Uri.parse("$_hostIP/products/$id"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }

  static Future<bool> deleteProduct(int id) async {
    var response = await client.delete(
      Uri.parse('$_hostIP/products'),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return false;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return false;
    }
  }

  static Future<List<ProductModel>?> searchProducts(String query) async {
    String encodedQuery = Uri.encodeFull(query.replaceAll('/', '%2F')); //todo: do the same for (.)
    var response = await client.get(
      Uri.parse("$_hostIP/products/search/$encodedQuery"),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    print("${productModelFromJson(response.body)}=====from request====");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return productModelFromJson(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return null;
    } else {
      js.context.callMethod('alert', [jsonDecode(response.body)["message"]]);
      return null;
    }
  }
}
