//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Radu Petrisel on 06.07.2023.
//

import SwiftUI

struct FlagImage: View {
    var flagName: String
    
    var body: some View {
        Image(flagName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(flagName: "UK")
    }
}
