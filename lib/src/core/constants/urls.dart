class Urls {
  static const _baseUrl = "https://botand-herbarium-api.herokuapp.com/api";

  static postUpdatePlantDetails(String uuid) => "$_baseUrl/plant/$uuid";
  static postOrderPlantActuator(String uuid) =>
      "$_baseUrl/plant/$uuid/actuators";
  static const getGreenhousesByUser = "$_baseUrl/greenhouses";
  static const putRegisterGreenhouse = "$_baseUrl/greenhouse/register";
  static postUpdateGreenhouse(String uuid) => "$_baseUrl/greenhouse/$uuid";
  static deleteGreenhouse(String uuid) => "$_baseUrl/greenhouse/$uuid";
  static const apiHealth = "$_baseUrl/health";
}
