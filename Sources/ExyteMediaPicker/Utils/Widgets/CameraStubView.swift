//
//  Created by Alex.M on 31.05.2022.
//

#if targetEnvironment(simulator)
import SwiftUI

struct CameraStubView: View {

    let didPressCancel: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .ignoresSafeArea()
            
            VStack {
                Text("相机")
                    .font(.largeTitle)
                Text("模拟器不支持相机，请在真机上测试")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                Button("关闭") {
                    didPressCancel()
                }
                .padding()
            }
            .foregroundStyle(.black)
        }
    }
}

struct CameraStubView_Preview: PreviewProvider {
    static var previews: some View {
        CameraStubView {
            debugPrint("close")
        }
    }
}

#endif
