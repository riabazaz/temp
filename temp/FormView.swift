//
//  FormView.swift
//
//
//  Created by Ria Bazaz on 5/7/20.
//


import SwiftUI

struct FormView: View {
    @EnvironmentObject var sessionStore : SessionStore
    @State  var steps : String
    @State  var waterfloz : String
    @State  var waste : Int
    @State var CO2 : Int
    @State var vegservings : Int
    @State var meatservings : Int
    @State var fruitservings : Int
    @State  var dairyservings : Int
    @State  var takeoutmeals : Int 


    var body: some View {
        VStack{
            Text("Tell us about your day!")
            
            Form(){
                    TextField("Steps taken", text : $steps)
                     .keyboardType(.numberPad)
                    TextField("Water (fl oz)", text : $waterfloz)
                    .keyboardType(.numberPad)
                

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
                        ZStack {
                            Rectangle()
                            Text("Submit")
                        }
                        
                    }
                    
                }
            }
            
        }.onAppear(perform: {
            self.vegservings = self.sessionStore.session!.todaypoints.vegservings
        })
        

    }
        func calcPoints() -> Int{
            return 30
        }
        
        func calcCO2() -> Int {
            return 1
        }
    
    func write(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        
//        var dateComponents = DateComponents()
//        dateComponents.setValue(1, for: .day);

        let now = formatter.string(from: Date()) // Current date
//        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)
        
        self.sessionStore.writePoints(date: now, overallpoints: self.calcPoints(), steps: Int(self.steps) ?? 10000, waterfloz: Int(self.waterfloz) ?? 100, waste: self.waste, CO2: self.calcCO2(), vegservings: self.vegservings, meatservings: self.meatservings, fruitservings: self.fruitservings, dairyservings: self.dairyservings, takeoutmeals: self.takeoutmeals) { (point, error) in
                if let error = error {
                  print("Error when signing up: \(error)")
                  return
                }
            
        }
    }
    
    //function to calculate points
    
    //update goals as well!!!!!
    
    
    
}

//struct FormView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormView()
//
//    }
//}



