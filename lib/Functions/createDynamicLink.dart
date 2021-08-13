import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<String> createDynamicLink(var bookId)async {
  //TODO: encode the bookId
  var uriPrefex = "https://notesandmore.page.link";
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: uriPrefex,
    link: Uri.parse('https://www.notesandmore.com/book/$bookId'),
    androidParameters: AndroidParameters(
      packageName: 'com.notesandmore.name',
      minimumVersion: 2,
    ),
    // iosParameters: IosParameters(
    //   bundleId: 'com.example.ios',
    //   minimumVersion: '1.1.0',
    //   appStoreId: '123456789',
    // ),
    // googleAnalyticsParameters: GoogleAnalyticsParameters(
    //   campaign: 'example-promo',
    //   medium: 'social',
    //   source: 'orkut',
    // ),
    // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
    //   providerToken: '123456',
    //   campaignToken: 'example-promo',
    // ),
    // socialMetaTagParameters:  SocialMetaTagParameters(
    //   title: 'Example of a Dynamic Link',
    //   description: 'This link works whether app is installed or not!',
    // ),
  );

  // final Uri dynamicUrl = await parameters.buildUrl();
  // print(dynamicUrl.toString());
  // return dynamicUrl.toString();
  final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
  final Uri shortUrl = shortDynamicLink.shortUrl;
  print(shortUrl.toString());
  return shortUrl.toString();
  // final ShortDynamicLink shortenedLink = await DynamicLinkParameters.shortenUrl(
  //   dynamicUrl,
  //   DynamicLinkParametersOptions(),
  // );
  //
  // final Uri shortUrl = shortenedLink.shortUrl;
  // print(shortUrl.toString());
}