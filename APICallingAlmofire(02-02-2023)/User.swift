//
//  User.swift
//  APICallingAlmofire(02-02-2023)
//
//  Created by undhad kaushik on 03/02/23.
//

import Foundation

struct User: Decodable{
    var id: Int
    var name: String
    var email: String
    var gender: String
    var status: String
}
