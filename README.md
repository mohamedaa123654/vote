# vote
This app to voting application, which allows voters to cast their votes over the mobile application.
All data Stor on FireStore and vote time. admin can see user data and varify access to vote.


This project is powered by Flutter **>=2.8.0** and Dart **>=2.18.0 <3.0.0**.

## User record
https://github.com/mohamedaa123654/vote/assets/33372890/7da4c6c0-632c-43a0-8e91-1d9de2ee1847



## Admin record
https://github.com/mohamedaa123654/vote/assets/33372890/61a08f60-79d7-4154-b39a-25684539959f




The main packages used in the project:
```yaml
  awesome_dialog: ^3.1.0
  cloud_firestore: ^4.7.1
  cupertino_icons: ^1.0.2
  dio: ^5.1.2
  firebase_auth: ^4.6.1
  firebase_core: ^2.13.0
  firebase_storage: ^11.2.1
  flutter:
    sdk: flutter
  flutter_countdown_timer: ^4.1.0
  get: ^4.6.5
  image_picker: ^0.8.7+5
  internet_connection_checker: ^1.0.0+1
  intl: ^0.18.1
  # lottie: ^2.3.2
  modal_progress_hud_nsn: ^0.4.0
  percent_indicator: ^4.2.3
  shared_preferences: ^2.1.1
  sizer: ^2.0.15
```

## Project structure <a name="structure"></a>
|   |   |
|---|---|
|*main.dart*|The entry point to the application. Here is the initialization of DioHelper, CacheHelper and registration of common Blocs and Sizer that are used throughout the application.|
|*application/*|constants, route maneger, network info and Cache helper|
|*Domain/*|repository, and usecases|
|*data/*|Model classes used in the application and data providers|
|*presentation/*|All UI elements used in the application.|
|---|---|
|*presentation/Controller/*|Contain Get Time controller.|
|*presentation/screens/*|Application screens.|
|*presentation/widgets/*|Common UI elements.|
|---|---|



