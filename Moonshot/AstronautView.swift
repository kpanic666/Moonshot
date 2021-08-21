//
//  AstronautView.swift
//  Moonshot
//
//  Created by Andrei Korikov on 12.08.2021.
//

import SwiftUI

struct AstronautView: View {
  struct AstronautMission {
      let missionName: String
      let role: String
  }
  
  let astronaut: Astronaut
  let missions: [Mission]
  let astronautMissions: [AstronautMission]
  
  init(astronaut: Astronaut, missions: [Mission]) {
    self.astronaut = astronaut
    self.missions = missions
    
    var matches = [AstronautMission]()
    
    for mission in missions {
      let filteredCrew = mission.crew.filter {
        $0.name == astronaut.id
      }
      
      let astrMission = filteredCrew.map {
        (crewRole: Mission.CrewRole) -> AstronautMission in
          AstronautMission(missionName: mission.displayName, role: crewRole.role)
      }
      
      if !astrMission.isEmpty {
        matches.append(contentsOf: astrMission)
      }
    }
    self.astronautMissions = matches
  }
  
  var body: some View {
    GeometryReader { geo in
      ScrollView {
        VStack {
          Image(astronaut.id)
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)
          
          Text(astronaut.description)
            .padding()
          
          Text("Missions:")
            .font(.title2)
          
          ForEach(astronautMissions, id: \.missionName) {
            Text("\($0.missionName)")
          }
        }
      }
    }
    .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
  }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  
  static var previews: some View {
    AstronautView(astronaut: astronauts[0], missions: missions)
  }
}
