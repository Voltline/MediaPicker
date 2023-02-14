//
//  CameraSelectionContainer.swift
//  
//
//  Created by Alisa Mylnikova on 12.07.2022.
//

import SwiftUI

public struct CameraSelectionTabView: View {

    @EnvironmentObject private var cameraSelectionService: CameraSelectionService

    @State private var index: Int = 0

    public var body: some View {
        TabView(selection: $index) {
            ForEach(cameraSelectionService.selected.enumerated().map({ $0 }), id: \.offset) { (index, media) in
                CameraSelectionCell(viewModel: CameraSelectionCellViewModel(media: media))
                    .tag(index)
                    .frame(maxHeight: .infinity)
                    .padding(.vertical)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct CameraSelectionContainer: View {

    @EnvironmentObject private var cameraSelectionService: CameraSelectionService
    @Environment(\.mediaPickerTheme) private var theme

    @ObservedObject var viewModel: MediaPickerViewModel

    @Binding var showingPicker: Bool

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    viewModel.onCancelCameraSelection(cameraSelectionService.hasSelected)
                }
                .foregroundColor(.white)
                Spacer()
            }
            .padding()

            CameraSelectionTabView()

            HStack {
                Button("Done") {
                    showingPicker = false
                }
                Spacer()
                Button {
                    viewModel.setPickerMode(.camera)
                } label: {
                    Image(systemName: "plus.app")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .foregroundColor(.white)
            .font(.system(size: 16))
            .padding()
        }
        .background(theme.main.cameraSelectionBackground)
    }
}
