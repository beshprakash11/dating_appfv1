//Personal info
  String uid= "";
  String imageProfile= "";
  String email= "";
  String password= "";
  String name= "";
  int age= "";
  String phoneNo= "";
  String city= "";
  String country= "";
  String profileHeading= "";
  String lookingForInaPartner= "";
  int publishedDateTime= "";

  //Appearance
  String height= "";
  String weight= "";
  String bodyType= "";

  //Life style
  String drink= "";
  String smoke= "";
  String martialStatus= "";
  String haveChildren= "";
  String noOfChildren= "";
  String profession= "";
  String employmentStatus= "";
  String income= "";
  String livingSituatin= "";
  String willingToRelocate= "";
  String relationshipYouAreLookingFor= "";

  //Background - Cultureal values
  String nationality= "";
  String education= "";
  String languageSpoken= "";
  String religion= "";
  String ethnicity= "";

## Key Properties
storePassword=sujatabesh3593779
keyPassword=sujatabesh3593779yogi
keyAlias=upload
storeFile=<keystore-file-location>

## Deployment flutter app
keytool -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
- keytool -genkey -v -keystore "C:\Users\beshp\Documents\Keys\upload-keystore.jks" -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload 
- tutorial:- 3:29 https://www.youtube.com/watch?v=ZxjgV1YaOcQ

- develop apk:- flutter build appbundle --release