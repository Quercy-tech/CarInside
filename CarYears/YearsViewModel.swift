//
//  YearsModel.swift
//  AutoInsight
//
//  Created by Quercy on 17.07.2024.
//

import Foundation
import Combine

struct YearsResponse: Codable {
    let records: [Record]

    struct Record: Codable {
        let fields: VehicleFields
    }
}

struct VehicleFields: Codable {
    let year: String
}

class YearsViewModel: ObservableObject {
    @Published var modelYears: [String] = []

    private var cancellable: AnyCancellable?

    func fetchVehicleYears(make: String?, model: String? = nil, completion: @escaping () -> Void) {
            var urlString = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=all-vehicles-model&rows=1000&sort=-fuelcost08"
            
            if let make = make {
                if make != "" {
                    urlString += "&refine.make=\(make)"
                }
            }
        
            if let model = model {
                if model != "" {
                    urlString += "&refine.model=\(model)"
                }
            }

            guard let url = URL(string: urlString) else {
                completion()
                return
            }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: YearsResponse.self, decoder: JSONDecoder())
            .map { response in
                response.records.compactMap { $0.fields.year }
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] modelYears in
                self?.modelYears = modelYears
                completion()
            }
    }
}

