
import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: Page2()) {
                    Text("Page 2")
                }
                NavigationLink(destination: Search()) {
                    Text("Search")
                }
            }
            .navigationBarTitleView(displayMode: .inline) { Text("Page 1").foregroundColor(.orange) }
        }
    }
}

struct Page2: View {

    var body: some View {
        Text("Page 2")
            .navigationBarTitleView(displayMode: .inline) { Text("Page 2").foregroundColor(.blue) }
    }
}

struct Search: View {

    @State var term = ""

    var body: some View {
        Text("Page 2")
            .navigationBarTitleView(displayMode: .inline) { TextField("Search", text: $term) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
