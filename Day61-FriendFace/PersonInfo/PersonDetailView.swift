//
//  PersonDetailView.swift
//  PersonInfo
//
//  Created by Zune Moe on 29/07/2021.
//

import SwiftUI
import CoreData

struct PersonDetailView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State var person: CDPerson
    @State private var friendList: [CDPerson] = []
    
    var body: some View {
        Form {
            Section(header:
                        Label {
                            Text("Info")
                        } icon: {
                            Image(systemName: "info.circle")
                                .renderingMode(.original)
                        }
            ) {
                Label {
                    Text("\(person.age) years old")
                        .font(.body)
                } icon: {
                    Image(systemName: "person")
                        .renderingMode(.original)
                }
                Label {
                    Text(person.wrappedEmail)
                        .font(.body)
                } icon: {
                    Image(systemName: "envelope")
                        .renderingMode(.original)
                }
                Label {
                    Text(person.formattedDate)
                        .font(.body)
                } icon: {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .renderingMode(.original)
                }
                Label {
                    Text(person.wrappedCompany)
                        .font(.body)
                } icon: {
                    Image(systemName: "building")
                        .renderingMode(.original)
                }
                Label {
                    Text(person.wrappedAddress)
                        .font(.body)
                } icon: {
                    Image(systemName: "signpost.right")
                        .renderingMode(.original)
                }
                Label {
                    Text(person.isActive ? "Active" : "Inactive")
                } icon: {
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(person.isActive ? .green : .gray)
                }
            }

            Section(header:
                        Label {
                            Text("Tags")
                        } icon: {
                            Image(systemName: "tag")
                                .renderingMode(.original)
                        }
            ) {
                TagsView(tags: person.tagArray)
            }

            Section(header:
                        Label {
                            Text("About")
                        } icon: {
                            Image(systemName: "person.circle")
                        }
            ) {
                Text(person.wrappedAbout)

            }

            Section(header:
                        Label {
                            Text("Friends")
                        } icon: {
                            Image(systemName: "person.3")
                        }
            ) {
                ForEach (friendList, id: \.self) { friend in
                    NavigationLink(destination: PersonDetailView(person: friend)) {
                        Label {
                            Text(friend.wrappedName)
                        } icon: {
                            Image(systemName: "person")
                                .renderingMode(.original)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(person.wrappedName, displayMode: .inline)
        .onAppear {
            fetchFriendsFromCD(person: person)
        }
    }
    
    func fetchFriendsFromCD(person: CDPerson) {
        var friendArray: [CDPerson] = []
        for friend in person.friendArray {
            let fetchRequest: NSFetchRequest<CDPerson> = CDPerson.fetchRequest()            
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id = %@", friend.wrappedID)
            let object = try? moc.fetch(fetchRequest).first            
            friendArray.append(object!)
        }
        friendList = friendArray
        print("Fetched friend list from core data")
    }
}
