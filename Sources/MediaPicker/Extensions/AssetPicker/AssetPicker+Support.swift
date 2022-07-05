//
//  Created by Alex.M on 07.06.2022.
//

import Foundation
import SwiftUI

extension View {
    func cameraSheet(isPresented: Binding<Bool>, image: Binding<URL?>) -> some View {

#if targetEnvironment(simulator)
        self.fullScreenCover(isPresented: isPresented) {
            CameraStubView(isPresented: isPresented)
        }
#elseif os(iOS)
        self.fullScreenCover(isPresented: isPresented) {
            CameraView(url: image, isPresented: isPresented)
        }
#endif
    }

    func mediaPickerToolbar(mode: Binding<MediaPickerMode>) -> some View {
        self.toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: mode) {
                    ForEach(MediaPickerMode.allCases) { mode in
                        Text(mode.name)
                            .tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }

    func mediaPickerNavigationBar(mode: Binding<MediaPickerMode>, close: @escaping () -> Void) -> some View {
        self
            .mediaPickerToolbar(mode: mode)
            .navigationBarTitleDisplayMode(.inline)
    }
}
