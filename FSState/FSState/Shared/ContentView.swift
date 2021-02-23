//
/*
 *		Created by 游宗諭 in 2021/2/20
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 10.15
 */

import SwiftUI

struct ContentView: View {
    @FSState var i = 0
    var body: some View {
        VStack {
            Text(i.description)
                .padding()
            Stepper("change value", value: $i)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
