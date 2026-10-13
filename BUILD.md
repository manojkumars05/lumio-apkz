# Lumio -> Android APK (Capacitor)

## Option A: Phone/GitHub (Android Studio vendaam)
1. GitHub-la oru new repo create pannunga, intha folder content ellam upload pannunga.
2. Actions tab -> "Build APK" -> Run workflow.
3. Mudinjathum Artifacts-la `lumio-debug-apk` download pannunga -> unzip -> app-debug.apk install.

## Option B: Laptop
Need: Node 18+, JDK 17, Android SDK
    npm install
    npx cap add android
    npm run apk
APK: android/app/build/outputs/apk/debug/app-debug.apk

## IMPORTANT - Firebase
Firebase console -> Authentication -> Settings -> Authorized domains -> add `localhost`
(app https://localhost-la run aagum; illana login work aagaadhu).

## App-la website changes / new features varalana
- App = https://manojkumars05.github.io/lumio/ site-ah load pannum (capacitor.config.json -> server.url). Website-ah GitHub Pages la update pannina, app-la 10 min la varum.
- Back button, download maari NATIVE features-ku APK-ah rebuild pannitu, pazhaya app uninstall panni, puthu APK install pannanum.
- Innum varalana: Phone Settings -> Apps -> Lumio -> Storage -> Clear cache.
