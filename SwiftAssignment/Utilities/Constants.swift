//
//  Constants.swift
//  SwiftAssignment
//
//  Created by Syed Tariq Ali on 31/05/21.
//

import Foundation
import UIKit

let alertMessage = "Host is not reachable . Please check your network connectivity"
let alertTitle = "NETWORK ISSUE"
let themeColor = UIColor.systemBlue
let themeNavTitleColor = UIColor.white
let themeTitleColor = UIColor.darkGray
let themeSubtitleColor = UIColor.gray

struct EndPoint {
    static let strUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}
enum APIError: String, Error {
    case serverUnavailable = "Server is unavailable"
    case permissionDenied = "Permission denied"
}
