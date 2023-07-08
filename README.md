<p align="center">
  <a href="https://retromusic.app">
    <img src="assets\images\icon.png" height="128">
    <h1 align="center">Paisa - Expense Tracker</h1>
  </a>
</p>
<p align="center">
 <a href="https://flutter.dev/" style="text-decoration:none" area-label="flutter">
    <img src="https://img.shields.io/badge/Platform-Flutter%203.10.4-blue">
  </a>
   <a href="https://play.google.com/store/apps/details?id=dev.hemanths.paisa" style="text-decoration:none" area-label="flutter">
    <img src="https://img.shields.io/badge/Download-Google%20Play-green">
  </a>
  <a href="https://github.com/RetroMusicPlayer/Paisa/releases/tag/v4.8.0" style="text-decoration:none" area-label="flutter">
    <img src="https://img.shields.io/badge/Version-4.8.0-orange">
  </a>
</p>
<p  align="center">
    <h2> Material design expense manager</h2>
</p>

### ⚠ Join [@paisa group](https://t.me/app_paisa) on Telegram for important updates

### Screen shots

#### Mobile

| <img src="paisa-images/flutter_01.png" width="200"/> | <img src="paisa-images/flutter_02.png" width="200"/> | <img src="paisa-images/flutter_04.png" width="200"/> |<img src="paisa-images/flutter_03.png" width="200"/> |
| :--: | :--: | :--: | :--: |
|Home|Accounts|Categories|Budget overview|

#### Foldable

| <img src="paisa-images/Screenshot_1667485291.png" width="200"/> | <img src="paisa-images/Screenshot_1667485297.png" width="200"/> | <img src="paisa-images/Screenshot_1667485299.png" width="200"/> |<img src="paisa-images/Screenshot_1667485301.png" width="200"/> |
| :--: | :--: | :--: | :--: |
|Home|Accounts|Categories|Budget overview|

#### Tablet & Desktop

 | <img src="paisa-images/Screenshot_1667485280.png" width="200"/> | <img src="paisa-images/Screenshot_1667485342.png" width="200"/> | <img src="paisa-images/Screenshot_1667485319.png" width="200"/> |<img src="paisa-images/Screenshot_1667485320.png" width="200"/> |
| :--: | :--: | :--: | :--: |
|Home|Accounts|Categories|Budget overview|

### Expense Tracking

- Tracking expenses, incomes & deposits
- Account & budget visw overview
- Manage categories
  
### Steps to translate

1. Create `.arb` file inside `lib/localization/app_<country_code>.arb` example `app_en.arb`
2. Copy all transactions from `app_en.arb` to created file and remove all keys which annotates with `@`
   From

   ```json
   {
    "appTitle": "Paisa",
    "@appTitle": {
        "description": "The app name",
        "type": "text",
        "placeholders": {}
    }
   }
    ```

    To

    ```json
    {
      "appTitle": "Paisa"
    }
    ```

3. Run the app and check once

### License

    Copyright (c) 2022, Hemanth S
    All rights reserved.
    
    This source code is licensed under the GPLv3-style license found in the
    LICENSE file in the root directory of this source tree. 
