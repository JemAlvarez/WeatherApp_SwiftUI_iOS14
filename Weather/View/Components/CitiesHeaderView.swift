//

import SwiftUI

struct CitiesHeaderView: View {
    @Binding var editing: Bool
    
    @State var search = ""
    @State var searchFieldWidth: CGFloat = .infinity
    @State var searching = false
    @State var showingSearchList = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: SearchListView(searchTerm: search), isActive: $showingSearchList) {EmptyView()}
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
                            showingSearchList = true
                        }
                        search = ""
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
                            .font(.title3)
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
            .font(.title2)
        }
    }
}

struct CitiesHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesHeaderView(editing: .constant(false))
    }
}
