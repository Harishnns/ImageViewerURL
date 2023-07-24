//
//  ImageStore.swift
//  ImageViwerURL
//
//  Created by HARISH NOMULA on 23/07/23.
//

import Foundation
class ImageStore {
    static let shared = ImageStore()
    
    private var images: [ImageModel] = []
    private let imageQueue = DispatchQueue(label: "com.example.imageQueue", qos: .userInitiated)
    private var imageCache: NSCache<NSString, NSData> = NSCache()
    
    private init() {}
    
    func addImage(_ image: ImageModel) {
        images.append(image)
    }
    
    func getImage(at index: Int, completion: @escaping (Data?) -> Void) {
        guard index >= 0 && index < images.count else {
            completion(nil)
            return
        }
        
        let imageModel = images[index]
                if let imageData = imageCache.object(forKey: imageModel.url as NSString) {
                    completion(imageData as Data)
                    return
                }
                
                guard let url = URL(string: imageModel.url) else {
                    completion(nil)
                    return
                }
                
                imageQueue.async {
                    if let imageData = try? Data(contentsOf: url) {
                        self.imageCache.setObject(imageData as NSData, forKey: imageModel.url as NSString)
                        completion(imageData)
                    } else {
                        completion(nil)
                    }
                }
            }
            
            func getImageTitles() -> [String] {
                return images.map { $0.title }
            }
        }
