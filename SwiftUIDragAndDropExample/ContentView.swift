//
//  ContentView.swift
//  DragCrash
//
//  Created by Rick Mann on 2023-12-24.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .frame(width: 200, height: 200)
        .background(.red)
        .padding()
#if false
		.onDrop(of: [.movie, .image], delegate: MyDropDelegate())			//	Crashes
#elseif true
		.onDrop(of: [.movie, .image], isTargeted: nil)						//	Crashes
		{ inProviders, inPoint in
			print("got something")
			for provider in inProviders
			{
				print("types: \(provider.registeredTypeIdentifiers)")
			}
			return true
		}
#elseif false		//	This one doesn't work for drops from Photos.app
		.dropDestination(for: URL.self) { items, location in
			print("got items: \(items)")
			return true
		}
#elseif false
		.dropDestination(for: Image.self)									//	Crashes
		{ items, location in
			print("Got items: \(items)")
			return true
		}
#elseif false
		.dropDestination(for: Data.self)									//	Crashes
		{ items, location in
			print("Got items: \(items)")
			return true
		}
#endif
    }
    
    class
    MyDropDelegate : DropDelegate
	{
		func performDrop(info: DropInfo) -> Bool {
			print("perform drop: \(String(describing: info))")
			let providers = info.itemProviders(for: [.image, .movie])
			print("Providers: \(providers)")
			let p: NSItemProvider = providers.first!
//			p.loadDataRepresentation(for: .image) { inData, inError in
//				print("got image")
//			}
			p.loadInPlaceFileRepresentation(forTypeIdentifier: UTType.image.identifier) { inURL, inInPlace, inError in
				print("got in place: \(inInPlace): \(inURL?.path)")
			}
//			try await p.loadInPlaceFileRepresentation(forTypeIdentifier: UTType.image.identifier)
			return true
		}
    }
}

#Preview {
    ContentView()
}
