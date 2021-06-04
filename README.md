# eMin Web

eMin Web/Mobile application

# Installation 
https://flutter.dev/docs/get-started/install

Install flutter as instructed before according to your platform

### Environments
- dev
- qa
- uat

### Back end urls
- https://emin-backend.dev2.diginex.fun/
- https://emin-backend.qa2.diginex.fun/
- https://emin-backend.uat2.diginex.fun/


### Running the app
- Go to project route directory
- flutter clean
- flutter pub get
- flutter run -d chrome -t lib\eminweb.dart --dart-define="BASE_URL=https://emin-backend.dev2.diginex.fun/" --release

Update BASE_URL values as per Back end urls mentioned above
