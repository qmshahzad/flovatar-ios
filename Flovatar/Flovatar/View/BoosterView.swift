//
//  BoosterView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 04.12.2021.
//

import SwiftUI

struct BoosterView: View {

    let imageName: String
    let name: String

    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            Text(name)
                .foregroundColor(.white)
                .font(Font.custom("Staatliches-Regular", size: 20))

            Image(imageName)
                .resizable()
                .scaledToFit()
        }
    }
}
