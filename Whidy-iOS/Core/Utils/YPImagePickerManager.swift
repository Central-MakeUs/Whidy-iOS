//
//  YPImagePickerManager.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 9/9/24.
//

import UIKit
import SwiftUI
import YPImagePicker

struct YPImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: Data
    @Binding var isShowing : Bool
    var screens : [YPPickerScreen] = [.photo, .library]
    
    // Make Coordinator for handling delegate methods
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // Create the YPImagePicker ViewController
    func makeUIViewController(context: Context) -> YPImagePicker {
        var config = YPImagePickerConfiguration()
        config.screens = screens // 사용할 기능 선택
        config.startOnScreen = .library // 시작 시 사용할 화면
        config.showsPhotoFilters = false // 필터 기능 사용 여부
        config.shouldSaveNewPicturesToAlbum = false
        
        // 언어 설정
        config.wordings.libraryTitle = "앨범"
        config.wordings.cameraTitle = "카메라"
        config.wordings.next = "확인"
        config.wordings.cancel = "취소"
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                if let imageData = photo.image.jpegData(compressionQuality: 0.8) {
                    selectedImage = imageData
                } else {
                    selectedImage = Data()
                }
            }
            picker.dismiss(animated: true) {
                isShowing = false
            }
        }
        return picker
    }
    
    // Update the ViewController (Not needed here)
    func updateUIViewController(_ uiViewController: YPImagePicker, context: Context) {}

    // Coordinator to handle delegate callbacks
    class Coordinator: NSObject {
        var parent: YPImagePickerView

        init(_ parent: YPImagePickerView) {
            self.parent = parent
        }
    }
}
