//
//  ContentView.swift
//  FetchAPIResponseDemo
//
//  Created by Joynal Abedin on 17/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var results = [EntryTask]()
    
    var body: some View {
        List(results, id: \.id) { data in
            VStack(alignment: .leading) {
                Text(data.title)
            }
        }.onAppear(perform: loadData)
        
    }
    
    func loadData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            print("Invalid API End Point")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([EntryTask].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
