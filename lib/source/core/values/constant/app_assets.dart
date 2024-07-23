abstract class AppAssets {
  static const String _assets = 'assets';

  ///region Subfolder assets

  static const String _images = '$_assets/images';
  static const String _jsons = '$_assets/jsons';
  static const String _svgs = '$_assets/svgs';

  ///region Image
  static const String emptyImage = '$_images/emptyImage';

  ///region Svgs
  static const String logo = '$_svgs/counter.svg';

  ///region jsons
  static const String bluetooth = '$_jsons/bluetooth.json';
  static const String failed = '$_jsons/failed.json';
  static const String notFound = '$_jsons/not_found.json';
  static const String settings = '$_jsons/settings.json';
  static const String success = '$_jsons/success.json';
}
