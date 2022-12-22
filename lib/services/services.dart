import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:inventory_app/env/enviroment_variables.dart' as Environment;
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/utils/utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

part 'request.dart';
part 'clients_services.dart';
part 'categories_service.dart';
part 'products_service.dart';
part 'tags_services.dart';
part 'action.dart';
