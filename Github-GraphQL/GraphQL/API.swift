//  This file was automatically generated and should not be edited.

import Apollo

public final class RepositoryByNameFetchQuery: GraphQLQuery {
  public static let operationString =
    "query RepositoryByNameFetch($repoName: String!, $numberOfItems: Int = 20) {\n  search(type: REPOSITORY, query: $repoName, first: $numberOfItems) {\n    __typename\n    edges {\n      __typename\n      node {\n        __typename\n        ... on Repository {\n          owner {\n            __typename\n            ... on User {\n              name\n            }\n            ... on Organization {\n              name\n            }\n          }\n          id\n          name\n          description\n          viewerHasStarred\n          languages(first: 1) {\n            __typename\n            nodes {\n              __typename\n              ... on Language {\n                name\n              }\n            }\n          }\n          stargazers {\n            __typename\n            totalCount\n          }\n        }\n      }\n    }\n  }\n}"

  public var repoName: String
  public var numberOfItems: Int?

  public init(repoName: String, numberOfItems: Int? = nil) {
    self.repoName = repoName
    self.numberOfItems = numberOfItems
  }

  public var variables: GraphQLMap? {
    return ["repoName": repoName, "numberOfItems": numberOfItems]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["type": "REPOSITORY", "query": GraphQLVariable("repoName"), "first": GraphQLVariable("numberOfItems")], type: .nonNull(.object(Search.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(search: Search) {
      self.init(snapshot: ["__typename": "Query", "search": search.snapshot])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(snapshot: snapshot["search"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("edges", type: .list(.object(Edge.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(edges: [Edge?]? = nil) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "edges": edges.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of edges.
      public var edges: [Edge?]? {
        get {
          return (snapshot["edges"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes = ["SearchResultItemEdge"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.selections)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(node: Node? = nil) {
          self.init(snapshot: ["__typename": "SearchResultItemEdge", "node": node.flatMap { $0.snapshot }])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (snapshot["node"] as? Snapshot).flatMap { Node(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue", "PullRequest", "Repository", "User", "Organization", "MarketplaceListing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLTypeCase(
              variants: ["Repository": AsRepository.selections],
              default: [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              ]
            )
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public static func makeIssue() -> Node {
            return Node(snapshot: ["__typename": "Issue"])
          }

          public static func makePullRequest() -> Node {
            return Node(snapshot: ["__typename": "PullRequest"])
          }

          public static func makeUser() -> Node {
            return Node(snapshot: ["__typename": "User"])
          }

          public static func makeOrganization() -> Node {
            return Node(snapshot: ["__typename": "Organization"])
          }

          public static func makeMarketplaceListing() -> Node {
            return Node(snapshot: ["__typename": "MarketplaceListing"])
          }

          public static func makeRepository(owner: AsRepository.Owner, id: GraphQLID, name: String, description: String? = nil, viewerHasStarred: Bool, languages: AsRepository.Language? = nil, stargazers: AsRepository.Stargazer) -> Node {
            return Node(snapshot: ["__typename": "Repository", "owner": owner.snapshot, "id": id, "name": name, "description": description, "viewerHasStarred": viewerHasStarred, "languages": languages.flatMap { $0.snapshot }, "stargazers": stargazers.snapshot])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var asRepository: AsRepository? {
            get {
              if !AsRepository.possibleTypes.contains(__typename) { return nil }
              return AsRepository(snapshot: snapshot)
            }
            set {
              guard let newValue = newValue else { return }
              snapshot = newValue.snapshot
            }
          }

          public struct AsRepository: GraphQLSelectionSet {
            public static let possibleTypes = ["Repository"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("description", type: .scalar(String.self)),
              GraphQLField("viewerHasStarred", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("languages", arguments: ["first": 1], type: .object(Language.selections)),
              GraphQLField("stargazers", type: .nonNull(.object(Stargazer.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(owner: Owner, id: GraphQLID, name: String, description: String? = nil, viewerHasStarred: Bool, languages: Language? = nil, stargazers: Stargazer) {
              self.init(snapshot: ["__typename": "Repository", "owner": owner.snapshot, "id": id, "name": name, "description": description, "viewerHasStarred": viewerHasStarred, "languages": languages.flatMap { $0.snapshot }, "stargazers": stargazers.snapshot])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The User owner of the repository.
            public var owner: Owner {
              get {
                return Owner(snapshot: snapshot["owner"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "owner")
              }
            }

            public var id: GraphQLID {
              get {
                return snapshot["id"]! as! GraphQLID
              }
              set {
                snapshot.updateValue(newValue, forKey: "id")
              }
            }

            /// The name of the repository.
            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            /// The description of the repository.
            public var description: String? {
              get {
                return snapshot["description"] as? String
              }
              set {
                snapshot.updateValue(newValue, forKey: "description")
              }
            }

            /// Returns a boolean indicating whether the viewing user has starred this starrable.
            public var viewerHasStarred: Bool {
              get {
                return snapshot["viewerHasStarred"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerHasStarred")
              }
            }

            /// A list containing a breakdown of the language composition of the repository.
            public var languages: Language? {
              get {
                return (snapshot["languages"] as? Snapshot).flatMap { Language(snapshot: $0) }
              }
              set {
                snapshot.updateValue(newValue?.snapshot, forKey: "languages")
              }
            }

            /// A list of users who have starred this starrable.
            public var stargazers: Stargazer {
              get {
                return Stargazer(snapshot: snapshot["stargazers"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "stargazers")
              }
            }

            public struct Owner: GraphQLSelectionSet {
              public static let possibleTypes = ["Organization", "User"]

              public static let selections: [GraphQLSelection] = [
                GraphQLTypeCase(
                  variants: ["User": AsUser.selections, "Organization": AsOrganization.selections],
                  default: [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  ]
                )
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public static func makeUser(name: String? = nil) -> Owner {
                return Owner(snapshot: ["__typename": "User", "name": name])
              }

              public static func makeOrganization(name: String? = nil) -> Owner {
                return Owner(snapshot: ["__typename": "Organization", "name": name])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              public var asUser: AsUser? {
                get {
                  if !AsUser.possibleTypes.contains(__typename) { return nil }
                  return AsUser(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsUser: GraphQLSelectionSet {
                public static let possibleTypes = ["User"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .scalar(String.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(name: String? = nil) {
                  self.init(snapshot: ["__typename": "User", "name": name])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The user's public profile name.
                public var name: String? {
                  get {
                    return snapshot["name"] as? String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "name")
                  }
                }
              }

              public var asOrganization: AsOrganization? {
                get {
                  if !AsOrganization.possibleTypes.contains(__typename) { return nil }
                  return AsOrganization(snapshot: snapshot)
                }
                set {
                  guard let newValue = newValue else { return }
                  snapshot = newValue.snapshot
                }
              }

              public struct AsOrganization: GraphQLSelectionSet {
                public static let possibleTypes = ["Organization"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .scalar(String.self)),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(name: String? = nil) {
                  self.init(snapshot: ["__typename": "Organization", "name": name])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The organization's public profile name.
                public var name: String? {
                  get {
                    return snapshot["name"] as? String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "name")
                  }
                }
              }
            }

            public struct Language: GraphQLSelectionSet {
              public static let possibleTypes = ["LanguageConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(nodes: [Node?]? = nil) {
                self.init(snapshot: ["__typename": "LanguageConnection", "nodes": nodes.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of nodes.
              public var nodes: [Node?]? {
                get {
                  return (snapshot["nodes"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
                }
                set {
                  snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes = ["Language"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                ]

                public var snapshot: Snapshot

                public init(snapshot: Snapshot) {
                  self.snapshot = snapshot
                }

                public init(name: String) {
                  self.init(snapshot: ["__typename": "Language", "name": name])
                }

                public var __typename: String {
                  get {
                    return snapshot["__typename"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The name of the current language.
                public var name: String {
                  get {
                    return snapshot["name"]! as! String
                  }
                  set {
                    snapshot.updateValue(newValue, forKey: "name")
                  }
                }
              }
            }

            public struct Stargazer: GraphQLSelectionSet {
              public static let possibleTypes = ["StargazerConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(totalCount: Int) {
                self.init(snapshot: ["__typename": "StargazerConnection", "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class StarRepositoryMutation: GraphQLMutation {
  public static let operationString =
    "mutation StarRepository($repositoryID: ID!) {\n  addStar(input: {starrableId: $repositoryID}) {\n    __typename\n    starrable {\n      __typename\n      viewerHasStarred\n      stargazers {\n        __typename\n        totalCount\n      }\n    }\n  }\n}"

  public var repositoryID: GraphQLID

  public init(repositoryID: GraphQLID) {
    self.repositoryID = repositoryID
  }

  public var variables: GraphQLMap? {
    return ["repositoryID": repositoryID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addStar", arguments: ["input": ["starrableId": GraphQLVariable("repositoryID")]], type: .object(AddStar.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addStar: AddStar? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "addStar": addStar.flatMap { $0.snapshot }])
    }

    /// Adds a star to a Starrable.
    public var addStar: AddStar? {
      get {
        return (snapshot["addStar"] as? Snapshot).flatMap { AddStar(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "addStar")
      }
    }

    public struct AddStar: GraphQLSelectionSet {
      public static let possibleTypes = ["AddStarPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("starrable", type: .nonNull(.object(Starrable.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(starrable: Starrable) {
        self.init(snapshot: ["__typename": "AddStarPayload", "starrable": starrable.snapshot])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The starrable.
      public var starrable: Starrable {
        get {
          return Starrable(snapshot: snapshot["starrable"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "starrable")
        }
      }

      public struct Starrable: GraphQLSelectionSet {
        public static let possibleTypes = ["Repository", "Gist"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("viewerHasStarred", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("stargazers", type: .nonNull(.object(Stargazer.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeRepository(viewerHasStarred: Bool, stargazers: Stargazer) -> Starrable {
          return Starrable(snapshot: ["__typename": "Repository", "viewerHasStarred": viewerHasStarred, "stargazers": stargazers.snapshot])
        }

        public static func makeGist(viewerHasStarred: Bool, stargazers: Stargazer) -> Starrable {
          return Starrable(snapshot: ["__typename": "Gist", "viewerHasStarred": viewerHasStarred, "stargazers": stargazers.snapshot])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Returns a boolean indicating whether the viewing user has starred this starrable.
        public var viewerHasStarred: Bool {
          get {
            return snapshot["viewerHasStarred"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "viewerHasStarred")
          }
        }

        /// A list of users who have starred this starrable.
        public var stargazers: Stargazer {
          get {
            return Stargazer(snapshot: snapshot["stargazers"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "stargazers")
          }
        }

        public struct Stargazer: GraphQLSelectionSet {
          public static let possibleTypes = ["StargazerConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(totalCount: Int) {
            self.init(snapshot: ["__typename": "StargazerConnection", "totalCount": totalCount])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the total count of items in the connection.
          public var totalCount: Int {
            get {
              return snapshot["totalCount"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "totalCount")
            }
          }
        }
      }
    }
  }
}

public final class UnstarRepositoryMutation: GraphQLMutation {
  public static let operationString =
    "mutation UnstarRepository($repositoryID: ID!) {\n  removeStar(input: {starrableId: $repositoryID}) {\n    __typename\n    starrable {\n      __typename\n      viewerHasStarred\n      stargazers {\n        __typename\n        totalCount\n      }\n    }\n  }\n}"

  public var repositoryID: GraphQLID

  public init(repositoryID: GraphQLID) {
    self.repositoryID = repositoryID
  }

  public var variables: GraphQLMap? {
    return ["repositoryID": repositoryID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("removeStar", arguments: ["input": ["starrableId": GraphQLVariable("repositoryID")]], type: .object(RemoveStar.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(removeStar: RemoveStar? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "removeStar": removeStar.flatMap { $0.snapshot }])
    }

    /// Removes a star from a Starrable.
    public var removeStar: RemoveStar? {
      get {
        return (snapshot["removeStar"] as? Snapshot).flatMap { RemoveStar(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "removeStar")
      }
    }

    public struct RemoveStar: GraphQLSelectionSet {
      public static let possibleTypes = ["RemoveStarPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("starrable", type: .nonNull(.object(Starrable.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(starrable: Starrable) {
        self.init(snapshot: ["__typename": "RemoveStarPayload", "starrable": starrable.snapshot])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The starrable.
      public var starrable: Starrable {
        get {
          return Starrable(snapshot: snapshot["starrable"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "starrable")
        }
      }

      public struct Starrable: GraphQLSelectionSet {
        public static let possibleTypes = ["Repository", "Gist"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("viewerHasStarred", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("stargazers", type: .nonNull(.object(Stargazer.selections))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeRepository(viewerHasStarred: Bool, stargazers: Stargazer) -> Starrable {
          return Starrable(snapshot: ["__typename": "Repository", "viewerHasStarred": viewerHasStarred, "stargazers": stargazers.snapshot])
        }

        public static func makeGist(viewerHasStarred: Bool, stargazers: Stargazer) -> Starrable {
          return Starrable(snapshot: ["__typename": "Gist", "viewerHasStarred": viewerHasStarred, "stargazers": stargazers.snapshot])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Returns a boolean indicating whether the viewing user has starred this starrable.
        public var viewerHasStarred: Bool {
          get {
            return snapshot["viewerHasStarred"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "viewerHasStarred")
          }
        }

        /// A list of users who have starred this starrable.
        public var stargazers: Stargazer {
          get {
            return Stargazer(snapshot: snapshot["stargazers"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "stargazers")
          }
        }

        public struct Stargazer: GraphQLSelectionSet {
          public static let possibleTypes = ["StargazerConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(totalCount: Int) {
            self.init(snapshot: ["__typename": "StargazerConnection", "totalCount": totalCount])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the total count of items in the connection.
          public var totalCount: Int {
            get {
              return snapshot["totalCount"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "totalCount")
            }
          }
        }
      }
    }
  }
}