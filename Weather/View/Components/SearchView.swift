//

import SwiftUI

struct SearchView: View {
    @Binding var showingSearchList: Bool
    
    @EnvironmentObject var cityViewModel: CityViewModel
    
    @State var maxCities = false
    @State var cityExists = false
    
    @FetchRequest(sortDescriptors: [])
    var cities: FetchedResults<City>
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            showingSearchList = false
                            cityViewModel.searchCity = miscData.tempCityModel
                            cityViewModel.loadingSearch = true
                        }
                    }) {
                        Text("Cancel")
                            .bold()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if cities.count <= 6 {
                            var canAdd = true
                            for city in cities {
                                if city.lat == cityViewModel.searchCity.cityData.lat && city.lon == cityViewModel.searchCity.cityData.lon {
                                    canAdd.toggle()
                                    withAnimation {
                                        cityExists = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            cityExists = false
                                            
                                            // hide search view
                                            showingSearchList = false
                                            cityViewModel.loadingSearch = true
                                        }
                                    }
                                }
                            }
                            
                            if canAdd {
                                // add cities view model
                                withAnimation {
                                    cityViewModel.savedCities.append(cityViewModel.searchCity)
                                }
                                
                                // add to core data
                                let city = City(context: PersistenceController.shared.container.viewContext)
                                city.lat = cityViewModel.searchCity.cityData.lat
                                city.lon = cityViewModel.searchCity.cityData.lon
                                city.type = "saved"
                                PersistenceController.shared.saveContext()
                                
                                withAnimation {
                                    // hide search view
                                    showingSearchList = false
                                    cityViewModel.loadingSearch = true
                                }
                            }
                        } else {
                            withAnimation {
                                maxCities = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    maxCities = false
                                    
                                    
                                    // hide search view
                                    showingSearchList = false
                                    cityViewModel.loadingSearch = true                                    }
                            }
                        }
                    }) {
                        Text("Add")
                            .bold()
                    }
                }
                .foregroundColor(.white)
                
                if cityViewModel.loadingSearch {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    VStack {
                        // TOP
                        HStack (alignment: .top) {
                            // LEFT
                            VStack (alignment: .leading, spacing: 0) {
                                Text("\(Int(cityViewModel.searchCity.cityData.current.temp))º")
                                     .font(.system(size: 35))
                                Text(cityViewModel.searchCity.cityName.city)
                                    .padding(.top, 7)
                                    .font(.system(size: 17))
                                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                HStack {
                                    Text(cityViewModel.searchCity.cityName.state)
                                    Text(cityViewModel.searchCity.cityName.country)
                                }
                                    .padding(.top, 4)
                                    .font(.system(size: 13))
                                    .opacity(0.5)
                            }
                            
                            Spacer()
                            
                            // RIGHT
                            Image(cityViewModel.getWeatherImage(id: cityViewModel.searchCity.cityData.current.weather[0].id))
                                .resizable()
                                .scaledToFit()
                                .frame(height: (UIScreen.main.bounds.width / 2.45) / 3.3)
                            
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        // BOTTOM
                        HStack {
                            SmallDataView(image: "drop", data: Text("\(Int(cityViewModel.searchCity.cityData.daily[0].pop * 100))%"), font: .system(size: 11))
                            Spacer()
                            SmallDataView(image: "wind", data: Text("\(cityViewModel.searchCity.cityData.current.wind_speed, specifier: "%.1f") \(cityViewModel.unit == "imperial" ? "mph" : "m/s")"), font: .system(size: 11))
                            
                        }
                        .padding(.bottom, 20)
                        .padding(.horizontal, 20)
                    }
                    .background(Color("backgroundLight"))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    
                }
            }
            .frame(height: UIScreen.main.bounds.height / 4)
            .padding()
            .background(Color("backgroundLight"))
            .cornerRadius(20)
            .padding(.horizontal, 50)
            
            if maxCities {
                Text("Maximum of 6 cities can be added.")
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(15)
            }
            
            if cityExists {
                Text("City already exists.")
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(15)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showingSearchList: .constant(true))
    }
}
