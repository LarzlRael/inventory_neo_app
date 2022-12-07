import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inventory_app/env/enviroment_variables.dart' as Environment;
import 'package:inventory_app/models/models.dart';

part 'request.dart';
part 'clients_services.dart';
part 'categories_service.dart';
part 'products_service.dart';
part 'tags_services.dart';
