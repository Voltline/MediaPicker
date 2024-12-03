//
//  Created by Alex.M on 06.06.2022.
//

import Foundation
import SwiftUI

struct PermissionsActionView: View {

    let action: Action
    
    @State private var showSheet = false
    
    var body: some View {
        ZStack {
            if showSheet {
                LimitedLibraryPickerProxyView(isPresented: $showSheet) {
                    NotificationCenter.default.post(
                        name: photoLibraryChangeLimitedPhotosNotification,
                        object: nil)
                }
                .frame(width: 1, height: 1)
            }
            
            switch action {
            case .library(let assetsLibraryAction):
                buildLibraryAction(assetsLibraryAction)
            case .camera(let cameraAction):
                buildCameraAction(cameraAction)
            }
        }
    }
}

private extension PermissionsActionView {
    
    @ViewBuilder
    func buildLibraryAction(_ action: PermissionsService.PhotoLibraryAction) -> some View {
        switch action {
        case .selectMore:
            PermissionsErrorView(text: "授权相册权限以查看图片") {
                showSheet = true
            }
        case .authorize:
            goToSettingsButton(text: "在设置中启用相册权限以查看图片")
        case .unavailable:
            PermissionsErrorView(text: "无法查看图片", action: nil)
        case .unknown:
            fatalError("未知权限问题")
        }
    }
    
    @ViewBuilder
    func buildCameraAction(_ action: PermissionsService.CameraAction) -> some View {
        switch action {
        case .authorize:
            goToSettingsButton(text: "在设置中启用相机权限以查看实时预览")
        case .unavailable:
            PermissionsErrorView(text: "摄像头不可用", action: nil)
        case .unknown:
            fatalError("未知权限问题")
        }
    }
    
    func goToSettingsButton(text: String) -> some View {
        PermissionsErrorView(
            text: text,
            action: {
                guard let url = URL(string: UIApplication.openSettingsURLString)
                else { return }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        )
    }
}

extension PermissionsActionView {
    enum Action {
        case library(PermissionsService.PhotoLibraryAction)
        case camera(PermissionsService.CameraAction)
    }
}
