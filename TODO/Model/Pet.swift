//
//  Pet.swift
//  TODO
//
//  Created by 장가겸 on 8/31/23.
//

import Foundation

struct Pets : Codable {
    var results : [Pet]
}

struct Pet : Codable {
    let id : String
    let url: String
    let width: Int
    let height : Int
}
