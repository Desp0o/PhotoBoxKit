//
//  AsyncCachedIamge.swift
//  PhotoBoxKit
//
//  Created by Despo on 31.05.25.
//

import SwiftUI
import Foundation

class CacheManager {
  @MainActor static let shared = NSCache<NSString, UIImage>()
}

@available(iOS 16.0, *)
struct AsyncCachedIamge: View {
  @State private var image: UIImage? = nil
  let url: URL?
  
  var body: some View {
    Group {
      if let uiImage = image {
        Image(uiImage: uiImage)
          .resizable()
      } else {
        if let url = url {
          ShimmerEffect()
            .task {
              await downloadImage(with: url)
            }
        }
      }
    }
  }
  
  private func downloadImage(with url: URL) async {
    let cacheKey = url.absoluteString as NSString
    
    if let cachedImage = CacheManager.shared.object(forKey: cacheKey) {
      self.image = cachedImage
      return
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let downloadedImage = UIImage(data: data) {
        
        CacheManager.shared.setObject(downloadedImage, forKey: cacheKey)
        
        self.image = downloadedImage
      }
    } catch {
      let _ = error
    }
  }
}
