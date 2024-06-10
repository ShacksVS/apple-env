//
//  ContentView.swift
//  Cats App
//
//  Created by Viktor Sovyak on 5/18/24.
//

import SwiftUI
import MyNetwork
import FirebasePerformance
import FirebaseCrashlytics

struct CatList: View {
    @State private var animals: [Animal] = []
    @State private var hasConsentedToCrashlytics = UserDefaults.standard.bool(forKey: UserDefaultsKeys.hasConsentedToCrashlytics)
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            Text("Here are some cute animals!")
                .font(.title)
            
            HStack {
                Button("1. Crash") {
                    Crashlytics.crashlytics().log("Fatal error occured after pressing '1. Crash'")
                    Crashlytics.crashlytics().setCustomValue("1.Crash", forKey: "CrashButton")
                    fatalError()
                }
                .padding(.horizontal)
                
                // Uncomment these if needed
//                Spacer()
//
//                Button("2. Crash") {
//                    Crashlytics.crashlytics().log("Forced nil unwrapping button pressed")
//                    Crashlytics.crashlytics().setCustomValue("2.Crash", forKey: "CrashButton")
//                    let nilOptional: String? = nil
//                    _ = nilOptional!
//                }
//
//                Spacer()
//
//                Button("3. Crash") {
//                    Crashlytics.crashlytics().log("Array out of bounds button pressed")
//                    Crashlytics.crashlytics().setCustomValue("3.Crash", forKey: "CrashButton")
//                    var array = [1, 2, 3]
//                    array.remove(at: 90)
//                }
//                .padding(.horizontal)
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(animals, id: \.self) { animal in
                        NavigationLink(value: animal) {
                            CatCell(animal: animal)
                        }
                    }
                    .navigationDestination(for: Animal.self) { animal in
                        CatDetails(animal: animal)
                    }
                    
                }
            }
        }
        .task {
            do {
                let traceApiFetch = Performance.startTrace(name: "fetching_data_api")
                Crashlytics.crashlytics().log("Started fetching cats data")
                animals = try await getAnimals()
                Crashlytics.crashlytics().log("Successfully fetched cats data")
                traceApiFetch?.stop()
            } catch {
                Crashlytics.crashlytics().log("Error fetching cats data: \(error)")
            }
        }
        .onAppear {
            if UserDefaults.standard.object(forKey: UserDefaultsKeys.hasConsentedToCrashlytics) == nil {
                showAlert = true
            } else {
                Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(hasConsentedToCrashlytics)
            }
            
            Crashlytics.crashlytics().log("User consent state: \(hasConsentedToCrashlytics)")
            Crashlytics.crashlytics().setCustomValue(hasConsentedToCrashlytics, forKey: "CrashlyticsConsent")
            print("User consented to Crashlytics: \(hasConsentedToCrashlytics)")
        }
        .alert("Collect data about crashes", isPresented: $showAlert) {
            Button("OK") {
                Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                hasConsentedToCrashlytics = true
                UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.hasConsentedToCrashlytics)
                Crashlytics.crashlytics().log("User consented to Crashlytics collection")
                Crashlytics.crashlytics().setCustomValue("true", forKey: "CrashlyticsConsent")
            }
            Button("Cancel", role: .cancel) {
                Crashlytics.crashlytics().log("User did not consent to Crashlytics collection")
                UserDefaults.standard.setValue(false, forKey: UserDefaultsKeys.hasConsentedToCrashlytics)
                Crashlytics.crashlytics().setCustomValue("false", forKey: "CrashlyticsConsent")
                Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
            }
        } message: {
            Text("Do you allow us to collect data about crashes to improve the app?")
        }
    }
}

#Preview {
    CatList()
}
