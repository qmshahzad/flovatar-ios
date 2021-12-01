//
//  SVGImage.swift
//  FCLDemo
//
//  Created by Yuriy Berdnikov on 30.11.2021.
//

import SwiftUI
import Macaw

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
        //svgView.contentMode = .scaleAspectFit
        svgView.contentScaleFactor = 2
        return svgView
    }

    func updateUIView(_ uiView: SVGView, context: Context) {
        uiView.node = (try? SVGParser.parse(text: image)) ?? Group()
    }
}
