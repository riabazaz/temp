//
//  FormView.swift
//
//
//  Created by Ria Bazaz on 5/7/20.
//


import SwiftUI

struct FormView: View {
    @EnvironmentObject var sessionStore : SessionStore
    @State private var steps : String = "10,000"
    @State private var waterfloz : String = "100"
    @State private var waste : Int = 0
    @State private var CO2 : Int = 0
    @State private var vegservings : Int = 0
    @State private var meatservings : Int = 0
    @State private var fruitservings : Int = 0
    @State private var dairyservings : Int = 0
    @State private var takeoutmeals : Int = 0


    var body: some View {
        VStack{
            Text("Tell us about your day!")
            
            Form{
                    TextField("Steps taken", text : $steps)
                     .keyboardType(.numberPad)
                    Text("Water (fl oz):  \(waterfloz)")
                    Picker(selection: $waterfloz, label: Text("")) {
                            ForEach(0 ..< 300) {
                                Text(String($0))
                            }
                    }
                    Stepper(value: $waste, in: 0...100, label: { Text("Number of plastic items: \(waste)")
                    })
                
                Section(header: Text("Food")) {
                    Stepper(value: $vegservings, in: 0...100, label: { Text("Servings of vegetables: \(vegservings)" )
                    })
                    Stepper(value: $meatservings, in: 0...100, label: { Text("Servings of meat: \(meatservings)")
                    })
                    Stepper(value: $fruitservings, in: 0...100, label: { Text("Servings of fruit: \(fruitservings)")
                    })
                    Stepper(value: $dairyservings, in: 0...100, label: { Text("Servings of dairy: \(dairyservings)")
                    })

                }
                
                
                Section {
                    Button(action: {
                        self.write()
                    }){
                        Rectangle()
                    }
                    
                }
            }
            
        }

    }
    
    func write(){
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .day);
        
        let now = Date() // Current date
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)
        
        sessionStore.writePoints(date: tomorrow!, overallpoints: calcPoints(), steps: Int(self.steps) ?? 10000, waterfloz: Int(self.waterfloz) ?? 100, waste: self.waste, CO2: calcCO2(), vegservings: self.vegservings, meatservings: self.meatservings, fruitservings: self.fruitservings, dairyservings: self.dairyservings, takeoutmeals: self.takeoutmeals) { (point, error) in
            if let error = error {
              print("Error when signing up: \(error)")
              return
            }
        }
    }
    
    //function to calculate points
    func calcPoints() -> Int{
        return 30
    }
    
    func calcCO2() -> Int {
        return 1
    }
    //update goals as well!!!!!
    
    
    
}

//struct FormView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormView()
//
//    }
//}


