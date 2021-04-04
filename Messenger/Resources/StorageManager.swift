//
//  StorageManager.swift
//  Messenger
//
//  Created by HieuTong on 4/2/21.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    /*
     /images/
     */
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    
    //uploads picture to firebase storage and returns completion with url sring to download
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil) { (metadata, error) in
            guard error == nil else {
                //failed
                print("failed to upload data to firebase")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("images/\(fileName)").downloadURL { (url, error) in
                guard let url = url else {
                    print("Failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownload))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            }
        }
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownload
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        
        reference.downloadURL { (url, error) in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownload))
                return
            }
            
            completion(.success(url))
        }
    }
}
