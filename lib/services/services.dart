import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

import 'package:inventory_app/env/environment_variables.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'request.dart';
part 'products_service.dart';
part 'action.dart';
part 'camera_gallery_service/camera_gallery_service_imp.dart';
part 'camera_gallery_service/camera_gallery_service.dart';

part 'key_value/key_value_storage_service_impl.dart';
part 'key_value/key_value_storage_service.dart';
