//
//  SVGImage.swift
//  FCLDemo
//
//  Created by Yuriy Berdnikov on 30.11.2021.
//

import SwiftUI
import Macaw
import UIKit

struct SVGImage: UIViewRepresentable {
    // a binding allows for dynamic updates to the shown image
    @Binding var image: String

    init(image: Binding<String>) {
        _image = image
    }

    // convenience constructor to allow for a constant image name
    init(image: String) {
        _image = .constant(image)
    }

    func makeUIView(context: Context) -> SVGView {
        let svgView = SVGView()
        svgView.backgroundColor = UIColor(white: 1.0, alpha: 0.0) // otherwise the background is black
        return svgView
    }

    func updateUIView(_ uiView: SVGView, context: Context) {
        DispatchQueue.global(qos: .userInitiated).async {
            let svg = (try? SVGParser.parse(text: image)) ?? Group()
        
            DispatchQueue.main.async {
                uiView.node = svg
            }
        }
    }
}
