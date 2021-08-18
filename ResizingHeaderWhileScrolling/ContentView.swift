//
//  ContentView.swift
//  ResizingHeaderWhileScrolling
//
//  Created by 민성홍 on 2021/08/13.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var index = 0
    @State var show = false

    var body: some View {
        VStack(spacing: 0) {
            appBar(index: $index, show: self.$show)
                .padding(.bottom, 30)

            ZStack {
                Chats(show: self.$show).opacity(self.index == 0 ? 1 : 0)
                Status().opacity(self.index == 1 ? 1 : 0)
                Calls().opacity(self.index == 2 ? 1 : 0)
            }
        }.edgesIgnoringSafeArea(.top)
    }
}

struct appBar: View {
    @Binding var index: Int
    @Binding var show: Bool

    var body: some View {
        VStack(spacing: 25) {

            HStack {
                Button(action: {}) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                Spacer()

                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 18, height: 18)
                }

                Button(action: {}) {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                .padding(.leading)
            }

            if self.show {
                HStack {
                    Button(action: {
                        self.index = 0
                    }) {
                        VStack {
                            Text("Chats")
                                .foregroundColor(.blue)
                                .fontWeight(self.index == 0 ? .bold : .none)

                            Capsule().fill(self.index == 0 ? Color.blue : Color.clear)
                                .frame(height: 4)
                        }
                    }

                    Button(action: {
                        self.index = 1
                    }) {
                        VStack {
                            Text("Status")
                                .foregroundColor(.blue)
                                .fontWeight(self.index == 1 ? .bold : .none)

                            Capsule().fill(self.index == 1 ? Color.blue : Color.clear)
                                .frame(height: 4)
                        }
                    }

                    Button(action: {
                        self.index = 2
                    }) {
                        VStack {
                            Text("Calls")
                                .foregroundColor(.blue)
                                .fontWeight(self.index == 2 ? .bold : .none)

                            Capsule().fill(self.index == 2 ? Color.blue : Color.clear)
                                .frame(height: 4)
                        }
                    }
                }.padding(.bottom, 10)
            }
        }
        .padding(.horizontal)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 10)
        .background(Color(.clear))
    }
}

struct Chats: View {
    @Binding var show: Bool

    var body: some View {
        List(0...25, id: \.self) { i in
            if i == 0 {
                CellView()
                    .onAppear {
                        withAnimation() {
                            self.show = true
                        }
                    }
                    .onDisappear {
                        withAnimation {
                            self.show = false
                        }
                    }
            } else {
                CellView()
            }

        }
    }
}

struct CellView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 55, height: 55)

            VStack(alignment: .leading, spacing: 10) {
                Text("Elisa")
                Text("Msg").font(.caption)
            }
        }
        .padding(.vertical, 4   )
    }
}

struct Status: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("Status")
            }
        }
    }
}

struct Calls: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("Calls")
            }
        }
    }
}

class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

