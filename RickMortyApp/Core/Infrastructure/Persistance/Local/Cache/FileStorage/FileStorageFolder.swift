//
//  FileStorageFolder.swift
//  RickMortyApp
//
//  Created by Rafael Loggiodice on 20/7/25.
//

enum FileStorageFolder: String {
    case characterCache = "CharacterCache"
    case imageCache = "ImageCache"
    
    var name: String {
        return rawValue
    }
}
