//
//  songResult.swift
//  drink
//
//  Created by fun on 2020/8/19.
//
import Foundation

struct SongResults : Decodable{
   let resultCount:Int
   let results:[song]
}

struct song : Decodable {
    
    let artistName:String
    let collectionName:String?
    let trackName:String
    let trackCensoredName:String
    let artistViewUrl:URL
    let collectionViewUrl:URL?
    let artworkUrl100:URL
    let collectionPrice:Double?
    let trackPrice:Double?
    let releaseDate:Date
    let previewUrl:URL
    
}
