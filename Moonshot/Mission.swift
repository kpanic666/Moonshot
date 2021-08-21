//
//  Mission.swift
//  Moonshot
//
//  Created by Andrei Korikov on 06.08.2021.
//

import Foundation

struct Mission: Codable, Identifiable {
  struct CrewRole: Codable {
    let name: String
    let role: String
  }
  
  let id: Int
  let launchDate: Date?
  let crew: [CrewRole]
  let description: String
  
  var displayName: String {
    "Apollo \(id)"
  }
  
  var image: String {
    "apollo\(id)"
  }
  
  var crewMemberNames: String {
    var memberNames = ""
    
    for member in crew {
      memberNames.append("\(member.name.capitalized), ")
    }
    memberNames.removeLast(2)
    return memberNames
  }
  
  var formattedLaunchDate: String {
    if let launchDate = launchDate {
      let formatter = DateFormatter()
      formatter.dateStyle = .short
      return formatter.string(from: launchDate)
    } else {
      return "N/A"
    }
  }
}
