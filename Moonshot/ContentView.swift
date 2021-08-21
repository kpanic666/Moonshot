//
//  ContentView.swift
//  Moonshot
//
//  Created by Andrei Korikov on 04.08.2021.
//

import SwiftUI

struct ContentView: View {
  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  @State private var isShowingCrewNames = false
  
  var body: some View {
    NavigationView {
      List(missions) { mission in
        NavigationLink(
          destination: MissionView(mission: mission, astronauts: astronauts, missions: missions)) {
          Image(mission.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 44, height: 44)
          
          VStack(alignment: .leading) {
            Text(mission.displayName)
            Text(isShowingCrewNames ? mission.crewMemberNames : mission.formattedLaunchDate)
          }
        }
      }
      .navigationBarTitle("Moonshot")
      .navigationBarItems(trailing: Button("\(isShowingCrewNames ? "Launch dates" : "Crew names")", action: {
        isShowingCrewNames.toggle()
      }))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
