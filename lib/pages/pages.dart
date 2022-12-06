import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:inventory_app/data/data.dart';
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/services/services.dart';
import 'package:inventory_app/utils/utils.dart';
import 'package:inventory_app/widgets/buttons/buttons.dart';
import 'package:inventory_app/widgets/delegate/delegates.dart';
import 'package:inventory_app/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';

part 'welcome_page.dart';
part 'home/home_page.dart';
part 'auth/select_login_page.dart';
/* Auth */
part 'auth/login_page.dart';

/* Bottom navigation page */
part 'home/bottom_navigation_pages/home.dart';
part 'home/bottom_navigation_pages/register.dart';
part 'home/bottom_navigation_pages/profile.dart';
part 'home/bottom_navigation_pages/inventory.dart';

/* Profile pages */

part 'profile/profile_page.dart';

/* Items  */
part 'items/item_detail_page.dart';

/* Clients pages */
part 'clients/clients_page.dart';
part 'clients/client_profile_page.dart';
part 'clients/client_register_page.dart';
