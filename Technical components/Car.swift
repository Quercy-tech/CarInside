//
//  Car.swift
//  AutoInsight
//
//  Created by Quercy on 10.07.2024.
//

import Foundation
import Combine

struct Car: Codable {
  let make: String
  let model: String
  let barrels08: Double?
  let city08: Int?
  let co2: Int?
  let comb08: Int?
  let cylinders: Int?
  let displ: Double?
  let drive: String?
  let fuelcosta08: Int?
  let fueltype1: String?
  let ghgscore: Int?
  let fescore: Int?
  let highway08: Int?
  let id: String?
  let trany: String?
  let vclass: String?
  let year: String
  let yousavespend: Int?
  let tcharger: String?
  let scharger: String?
  let evmotor: String?
  let startstop: String?
  let eng_dscr: String?
}

class CarSpecificationsViewModel: ObservableObject {
    @Published var cars: [Car] = []
    private var cancellable: AnyCancellable?

    func fetchCars(make: String?, model: String?, year: String?, fuel: String?, completion: @escaping () -> Void) {
        var urlString = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=all-vehicles-model&q=&sort=modifiedon&facet=make&facet=model&facet=year&rows=1000"
        
        if let make = make, !make.isEmpty {
            urlString += "&refine.make=\(make)"
        }
        
        if let model = model, !model.isEmpty {
            urlString += "&refine.model=\(model)"
        }
        
        if let year = year, !year.isEmpty {
            urlString += "&refine.year=\(year)"
        }
        if let fuel = fuel, !fuel.isEmpty {
            urlString += "&refine.fueltype=\(fuel)"
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion()
            return
        }
        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
                if (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) != nil {
                } else {
                    print("Failed to parse JSON response")
                }
            })
            .decode(type: FullResponse.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { response in
            })
            .map { response in
                response.records.compactMap { $0.fields }
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cars in
                self?.cars = cars
                completion()
            }
    }
    
}

struct FullResponse: Codable {
    let records: [Record]
    
    struct Record: Codable {
        let fields: Car
    }
}


