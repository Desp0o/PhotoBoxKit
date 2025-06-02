// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 16.0, *)
public struct PhotoBoxKit: View {
  @State private var isFading = false
  
  @Binding var activeIndex: Int
  @Binding var isVisible: Bool
  
  let urls: [String]
  let counter: Bool
  let gallery: Bool
  let cornerRadius: CGFloat
  let bgColor: Color
  let counterColor: Color
  
  public init(
    isFading: Bool = false,
    activeIndex: Binding<Int>,
    isVisible: Binding<Bool>,
    urls: [String],
    counter: Bool = true,
    gallery: Bool = true,
    cornerRadius: CGFloat = 0.0,
    bgColor: Color = Color.black.opacity(0.9),
    counterColor: Color = Color.white
  ) {
    self._isFading = State(initialValue: isFading)
    self._isVisible = isVisible
    self._activeIndex = activeIndex
    self.urls = urls
    self.counter = counter
    self.gallery = gallery
    self.cornerRadius = cornerRadius
    self.bgColor = bgColor
    self.counterColor = counterColor
  }
  
  @available(iOS 16.0, *)
  public var body: some View {
    ZStack {
      if isVisible {
        bgColor.ignoresSafeArea()
          .onTapGesture {
            isVisible = false
          }
        
        VStack {
          Spacer()
          
          AsyncCachedIamge(url: URL(string: urls[activeIndex]))
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .opacity(isFading ? 0 : 1)
            .onAppear {
              isFading = false
            }
            .id(activeIndex)
            .onChange(of: activeIndex) { _ in
              isFading = true
            }
            .padding(.horizontal, 20)
          
          Spacer()
          
          VStack {
            if counter {
              Text("\(activeIndex + 1) / \(urls.count)")
                .foregroundColor(counterColor)
            }
            if gallery {
              ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                  LazyHStack(spacing: 10) {
                    ForEach(urls.indices, id: \.self) { index in
                      let url = urls[index]
                      AsyncCachedIamge(url: URL(string: url))
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                        .overlay {
                          if index == activeIndex {
                            RoundedRectangle(cornerRadius: cornerRadius)
                              .stroke(Color.white, lineWidth: 1)
                          }
                        }
                        .onTapGesture {
                          withAnimation(.snappy(duration: 0.3)) {
                            activeIndex = index
                          }
                        }
                        .id(index)
                    }
                  }
                  .frame(height: 50)
                  .padding(.horizontal, 20)
                }
                .onChange(of: activeIndex) { index in
                  withAnimation(.snappy(duration: 0.3)) {
                    proxy.scrollTo(index, anchor: .center)
                  }
                }
                .onAppear {
                  proxy.scrollTo(activeIndex, anchor: .center)
                }
                .scrollIndicators(.hidden)
              }
            }
          }
        }
        .gesture(
          DragGesture()
            .onEnded { value in
              withAnimation(.snappy(duration: 0.3)) {
                if value.translation.width < -100 {
                  nextImage()
                } else if value.translation.width > 100 {
                  prevImage()
                }
              }
              
              if value.translation.height > 200 {
                isVisible = false
              }
            }
        )
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  private func nextImage() {
    if  activeIndex < urls.count - 1 {
      activeIndex += 1
    } else {
      activeIndex = 0
    }
  }
  
  private func prevImage() {
    if activeIndex > 0 {
      activeIndex -= 1
    } else {
      activeIndex = urls.count - 1
    }
  }
}

@available(iOS 16.0, *)
struct PhotoBoxKitModifier: ViewModifier {
  let boxkit: PhotoBoxKit
  public func body(content: Content) -> some View {
    content
      .overlay(boxkit)
  }
}

@available(iOS 16.0, *)
public extension View {
  func photoBoxKit(
    activeIndex: Binding<Int>,
    isVisible: Binding<Bool>,
    urls: [String],
    counter: Bool = true,
    gallery: Bool = true,
    cornerRadius: CGFloat = 0,
    bgColor: Color = Color.black.opacity(0.9),
    counterColor: Color = Color.white
  ) -> some View {
    modifier(
      PhotoBoxKitModifier(
        boxkit: PhotoBoxKit(
          activeIndex: activeIndex,
          isVisible: isVisible,
          urls: urls,
          counter: counter,
          gallery: gallery,
          cornerRadius: cornerRadius,
          bgColor: bgColor,
          counterColor: counterColor
        )
      )
    )
  }
}
