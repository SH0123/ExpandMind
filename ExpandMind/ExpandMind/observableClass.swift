//
//  observableClass.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/02.
//

import Foundation

class Store: ObservableObject {

    @Published var howMany: Int {


        didSet {

            UserDefaults.standard.set(howMany, forKey: "temperature")

        }

    }

    @Published var count: Int {

        didSet {

            UserDefaults.standard.set(count, forKey: "speed")

        }

    }
    @Published var isLaunched: Bool{
        didSet{
            UserDefaults.standard.set(isLaunched, forKey:"isLaunched")
        }
    }


    init() {


        self.howMany = UserDefaults.standard.integer(forKey: "howMany") + 1

        self.count = UserDefaults.standard.integer(forKey: "count")
        
        self.isLaunched = UserDefaults.standard.bool(forKey: "isLaunched")

    }

}
