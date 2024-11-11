# Translation API Demo App

This demo app showcases the capabilities of Apple's new Translation API for developers. The app is divided into three main sections: **System UI Translation**, **Custom UI Translation**, and **Availability**. Each section highlights different aspects of the API, providing a comprehensive view of its integration and capabilities.

## Sections

### 1. System UI Translation
In the **System UI Translation** section, we demonstrate how to leverage the built-in translation features provided by the system. This allows developers to integrate translation functionality with minimal setup, enabling translations directly within Apple’s system-provided UI components.

![Overlay Translation](https://github.com/user-attachments/assets/b5da2648-f798-43b9-a0df-e3db3ab30819)
![Replace Translation](https://github.com/user-attachments/assets/02987970-1d29-454c-bc1b-62d2eadb57d5)


#### Key Features:
- Just like copying and pasting a text to Translate app of Apple.
- Efficient, out-of-the-box solution for quick integration.
- Ideal for applications that want to provide basic translation without custom UI work.
- Replace feature, allows you to replace the translated text inside your app.

### 2. Custom UI Translation
The **Custom UI Translation** section illustrates how developers can use the Translation API within their own custom-designed UI components. This section is perfect for applications needing a unique translation experience while still taking advantage of the API’s powerful capabilities.

![single string](https://github.com/user-attachments/assets/93e43ef3-2e40-4102-8fb4-39046f604f83)
![sequential](https://github.com/user-attachments/assets/610354ba-4f63-4bad-b9a2-1585a2d32ec8)
![batch of strings](https://github.com/user-attachments/assets/b76b0108-4e29-4992-b971-2ebd120bb656)


#### Key Features:
- Full control over translation behavior within custom UI elements.
- Translate texts asyncronously. All at once, or as they get ready.
- Best suited for apps requiring a more tailored translation experience.

### 3. Availability
The **Availability** section checks the availability of translations based on user preferences, device settings, and installed language packs. This ensures users have access to the most relevant and efficient translations, even offline if language packs are downloaded.

![availability](https://github.com/user-attachments/assets/3e99cfd6-68b3-49e5-a556-3ce34fe043a3)
![prepare](https://github.com/user-attachments/assets/cf7efcb3-e91f-4af9-b281-f49a15d93879)


#### Key Features:
- Detects and manages language packs for offline translation.
- Notifies users about language availability and offers options to download necessary languages.
- Essential for apps aiming to support multilingual users in offline scenarios.

## Getting Started

To explore the demo:
1. Clone this repository.
2. Open the project in Xcode.
3. Build and run the app on a device with iOS 18.0 or later.

Each section in the app provides examples of how to implement the Translation API effectively for various needs. Whether you're looking for rapid integration through system components, custom UI flexibility, or reliable availability options, this app serves as a helpful guide.

## Requirements

- iOS 18.0 or later
- Xcode 16 or later

