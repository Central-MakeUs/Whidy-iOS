//
//  NetworkMonitor.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 10/15/24.
//

import SwiftUI
import Network

final class NetworkMonitor : ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    @Published var isDisConnected: Bool = false
    
    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                isDisConnected = path.status == .satisfied ? false : true
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func stop() {
        monitor.cancel()
    }
}
