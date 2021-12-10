import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String plantTagAsset(String name) =>
    "assets/images/plant_${name.toLowerCase()}_tag.png";

String plantTypeToLocalized(AppLocalizations intl, String name) {
  String localizedString;

  switch (name) {
    case "chive":
      localizedString = intl.plant_type_chive;
      break;
    case "coriander":
      localizedString = intl.plant_type_coriander;
      break;
    case "parsley":
      localizedString = intl.plant_type_parsley;
      break;
    case "thyme":
      localizedString = intl.plant_type_thyme;
      break;
    case "lettuce":
      localizedString = intl.plant_type_lettuce;
      break;
    case "cherry_tomatoes":
      localizedString = intl.plant_type_cherry_tomatoes;
      break;
    default:
      localizedString = intl.plant_type_default;
      break;
  }

  return localizedString;
}