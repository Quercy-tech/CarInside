//
//  ModelsViewModel.swift
//  AutoInsight
//
//  Created by Quercy on 16.07.2024.
//

import Foundation
import Combine

struct VehicleModel: Codable {
    let model: String
}

class VehicleViewModel: ObservableObject {
    @Published var models: [String] = []

    private var cancellable: AnyCancellable?

    func fetchVehicleModels(make: String?, completion: @escaping () -> Void) {
        var urlString = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=all-vehicles-model&rows=10000&sort=-fuelcost08"
        
        if let make = make {
            if make != "" {
                urlString += "&refine.make=\(make)"
            }
        }
        
        guard let url = URL(string: urlString) else {
            completion()
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: VehicleResponse.self, decoder: JSONDecoder())
            .map { response in
                response.records.map { $0.fields.model }
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] models in
                self?.models = models
                completion()
            }
    }
}

struct VehicleResponse: Codable {
    let records: [Record]

    struct Record: Codable {
        let fields: VehicleModel
    }
}

