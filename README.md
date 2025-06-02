
<img src="https://github.com/user-attachments/assets/1175c466-58f1-42d8-a986-7c7ec55dcf47" alt="PhotoBoxKit" width="400" height="auto" />


# PhotoBoxKit 🌃

#### PhotoBoxKit is a lightweight, Swift-native library designed for seamless photo viewing experiences in SwiftUI. It enables developers to present images with customizable backgrounds, swipe gestures, and smooth transitions. To improve performance and memory efficiency, PhotoBoxKit leverages NSCache for smart image caching and reuse.

![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![iOS](https://img.shields.io/badge/iOS-16.0%2B-white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-skyblue)
![Xcode](https://img.shields.io/badge/Xcode-16.3-blue)

## API Reference
 
| Parameter         | Type                 | Description                                           | Default |
|------------------|----------------------|-------------------------------------------------------|---------|
| `activeIndex`       | `Binding<Int>`             | API endpoint URL.                                     | N/A     |
| `isVisible`          | `Binding<Bool>`         | HTTP request method.                                  | N/A     |
| `urls`            | `[String]`            | Request payload.                                      | N/A     |
| `counter`         | `Bool`   | HTTP headers.                                         | true     |
| `gallery` | `Bool`       | Request timeout duration.                             | true     |
| `cornerRadius`        | `CGFloat`               | Enables caching for GET requests.                     | 0.0   |
| `bgColor`     | `Color`       | Cache validity duration.                              | Color.black.opacity(0.9)   |
| `counterColor`     | `Color`       | Cache validity duration.                              | Color.white   |

## Simple Usage
#### Just pass these three parameters for a basic setup:
- activeIndex – a state to track the currently selected image
- isVisible – a state to show or hide the photo box
- urls – an array of image URLs

#### That’s all you need to get started!

```swift
struct ContentView: View {
  @State private var isVisible: Bool = false
  @State private var activeIndex = 0
  
  let imageUrls: [String] = ["url1", "url2" ..... "url100"]
  
  var body: some View {
    VStack {
      // your code logic here
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .photoBoxKit(activeIndex: $activeIndex, isVisible: $isVisible, urls: imageUrls)
  }
}

```

## Custom PhotoBox

```swift
struct ContentView: View {
  @State private var isVisible: Bool = false
  @State private var activeIndex = 0
  
  let imageUrls: [String] = ["url1", "url2" ..... "url100"]
  
  var body: some View {
    VStack {
      // your code logic here
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .photoBoxKit(
      activeIndex: $activeIndex,
      isVisible: $isVisible,
      urls: imageUrls,
      counter: true,
      gallery: false,
      cornerRadius: 12,
      bgColor: .teal,
      counterColor: .black
    )
  }
}
```

## Demo 📸

![0603](https://github.com/user-attachments/assets/cbacd0d5-274f-426f-b9cc-12795806e1b1)

