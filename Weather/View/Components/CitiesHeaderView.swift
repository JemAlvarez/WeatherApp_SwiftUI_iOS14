//

import SwiftUI

struct CitiesHeaderView: View {
    @Binding var editing: Bool
    @Binding var showingSearchList: Bool
    @Binding var search: String
    @Binding var searching: Bool
    
    @State var searchFieldWidth: CGFloat = .infinity
    
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var cityViewModel: CityViewModel
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    withAnimation {
                        searching = true
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                }
                
                HStack {
                    TextField("Search", text: $search, onCommit:  {
                        if !search.isEmpty {
                            locationManager.getLocation(search) { location in
                                cityViewModel.cityRequest(location: location, save: "search", unit: nil)
                            }
                            
                            withAnimation {
                                showingSearchList = true
                            }
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        search = ""
                        hideKeyboard()
                        
                        withAnimation {
                            searching.toggle()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.accentColor)
                    }
                    .offset(x: searching ? 0 : 500)
                }
                 .frame(maxWidth: searching ? .infinity : 0)
                
                Text("Saved Cities")
                    .frame(maxWidth: searching ? 0 : .infinity, maxHeight: 20, alignment: .leading)
                
                Spacer()
                
                Button (action: {
                    editing.toggle()
                }) {
                    Image(systemName: "pencil")
                }
            }
            .padding(.horizontal)
            .font(.system(size: 23))
        }
    }
}

struct CitiesHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesHeaderView(editing: .constant(true), showingSearchList: .constant(false), search: .constant(""), searching: .constant(false))
    }
}
