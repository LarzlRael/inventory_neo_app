import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/pages/pages.dart';
import 'package:inventory_app/providers/providers.dart';
import 'package:inventory_app/utils/utils.dart';
import 'package:inventory_app/widgets/buttons/buttons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
part 'text/simple_text.dart';
/* Slides and banners */
part 'slideshow/slideshow.dart';
part 'slideshow/slide_banner_item.dart';
part 'banner_login.dart';

part 'common/app_bar_with_back_icon.dart';

/* Alerts */
part 'dialogs/material_dialog.dart';

/* Cards */
part 'cards/card_item_inventory.dart';
part 'cards/card_inventory_vertical.dart';
part 'cards/card_inventory_selectable.dart';
part 'cards/material_item_card.dart';
part 'cards/image_gallery.dart';

/* Clients */
part 'client/client_item.dart';

/* Errors widgets */
part 'errors/no_information.dart';

/* Forms */

part 'forms/custom_text_field.dart';
part 'forms/custom_dropdown_fetch.dart';
part 'forms/custom_radio_buttons.dart';
part 'forms/custom_file_field.dart';
part 'forms/custom_login_text_field.dart';

/* Loadings */
part 'loadings/simple_loading.dart';
/* Notifications */
part 'notificacion/global_snackbar.dart';

/* form */
part 'form_generator/input.dart';
part 'form_generator/global_form.dart';

/* Common widget */
part 'common/stream_data_builder.dart';
part 'buttons/selectable_items.dart';

/* Animations widgets */

part 'anim/fade_in_opacity.dart';
part 'anim/fade_in_right.dart';
part 'anim/fade_in_transition.dart';
