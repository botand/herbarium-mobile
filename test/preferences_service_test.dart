import 'package:flutter_test/flutter_test.dart';
import 'package:herbarium_mobile/src/core/constants/preference_flags.dart';
import 'package:herbarium_mobile/src/core/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences? sharedPreferences;

  PreferencesService? service;

  SharedPreferences.setMockInitialValues({});

  group("PreferencesService - ", () {
    setUp(() async {
      sharedPreferences = await SharedPreferences.getInstance();

      service = PreferencesService();
    });

    group("setters - ", () {
      test("setBool", () async {
        expect(
            await service!.setBool(
                PreferenceFlag.userLanguage,
                value: true),
            isTrue);
        expect(
            sharedPreferences!.getBool(
                PreferenceFlag.userLanguage.toString()),
            isTrue);
      });

      test("setString", () async {
        expect(
            await service!.setString(
                PreferenceFlag.userLanguage, "Test"),
            isTrue);
        expect(
            sharedPreferences!.getString(
                PreferenceFlag.userLanguage.toString()),
            "Test");
      });

      test("setInt", () async {
        expect(
            await service!.setInt(
                PreferenceFlag.userLanguage, 1),
            isTrue);
        expect(
            sharedPreferences!.getInt(
                PreferenceFlag.userLanguage.toString()),
            1);
      });
    });

    test("clear", () async {
      SharedPreferences.setMockInitialValues(
          {PreferenceFlag.userLanguage.toString(): true});

      expect(
          await service!.getBool(PreferenceFlag.userLanguage),
          isTrue);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();

      expect(
          await service!.getBool(PreferenceFlag.userLanguage),
          null);
    });

    group("getters - ", () {
      test("get", () async {
        SharedPreferences.setMockInitialValues(
            {PreferenceFlag.userLanguage.toString(): true});

        expect(
            await service!.getPreferenceFlag(
                PreferenceFlag.userLanguage),
            isInstanceOf<bool>());
      });

      test("getBool", () async {
        SharedPreferences.setMockInitialValues(
            {PreferenceFlag.userLanguage.toString(): true});

        expect(
            await service!
                .getBool(PreferenceFlag.userLanguage),
            isTrue);
      });

      test("getString", () async {
        SharedPreferences.setMockInitialValues({
          PreferenceFlag.userLanguage.toString(): "Test"
        });

        expect(
            await service!
                .getString(PreferenceFlag.userLanguage),
            "Test");
      });

      test("getInt", () async {
        SharedPreferences.setMockInitialValues(
            {PreferenceFlag.userLanguage.toString(): 1});

        expect(
            await service!
                .getInt(PreferenceFlag.userLanguage),
            1);
      });
    });
  });
}