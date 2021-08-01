//
//  PersonView.swift
//  PersonInfo
//
//  Created by Zune Moe on 29/07/2021.
//

import SwiftUI
import CoreData

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")    
}

struct PersonView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CDPerson.entity(), sortDescriptors: [
                    NSSortDescriptor(key: "isActive", ascending: false),
                    NSSortDescriptor(key: "name", ascending: true)]) var persons: FetchedResults<CDPerson>
    
    var body: some View {
        NavigationView {
            List(persons, id: \.self) { person in
                NavigationLink(destination: PersonDetailView(person: person)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(person.wrappedName)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Label {
                                Text(person.wrappedEmail)
                                    .font(.body)
                            } icon: {
                                Image(systemName: "envelope")
                                    .renderingMode(.original)
                            }
                            .foregroundColor(.secondary)
                            Label {
                                Text(person.formattedDate)
                                    .font(.body)
                            } icon: {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                    .renderingMode(.original)
                            }
                            .foregroundColor(.secondary)
                            Label {
                                Text(person.wrappedCompany)
                                    .font(.body)
                            } icon: {
                                Image(systemName: "building")
                                    .renderingMode(.original)
                            }
                            .foregroundColor(.secondary)
                        }
                        Spacer()
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(person.isActive ? .green : .gray)
                    }
                }
            }
            .navigationBarTitle("Profiles")         
            .onAppear() {
                if !UserDefaults.standard.bool(forKey: "SavedToCD") {
                    fetchPersonsFromAPI()
                }
            }
        }
    }
    
    func fetchPersonsFromAPI() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                debugPrint("No data in response \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            print(paths[0])
            
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = moc
            do {
                let decoded = try decoder.decode([CDPerson].self, from: data)
                if moc.hasChanges {
                    try? moc.save()
                    
                    UserDefaults.standard.set(true, forKey: "SavedToCD")
                    print("Successfully saved to CD")
                }
            } catch {
                print("Decoding Failed: \(error.localizedDescription)")
            }
        }.resume()
    }
}
