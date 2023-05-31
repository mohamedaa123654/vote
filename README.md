# vote
This project is powered by Flutter **>=2.8.0** and Dart **>=2.18.0 <3.0.0**.



#Screen Record
https://github.com/mohamedaa123654/vote/assets/33372890/83141a11-fa94-4b62-bb55-9925b7501f4a



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
|*Domain/*|constants, route maneger, network info and Cache helper|
|*data/*|Model classes used in the application and data providers (local and remote) network(requests, responses).|
|*presentation/*|All UI elements used in the application.|
|---|---|
|*presentation/Controller/*|Contain Get Time controller.|
|*presentation/screens/*|Application screens.|
|*presentation/widgets/*|Common UI elements.|
|---|---|



