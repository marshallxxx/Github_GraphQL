//  This file was automatically generated and should not be edited.

import Apollo

public final class RepositoryByNameQuery: GraphQLQuery {
  public static let operationString =
    "query RepositoryByName($repoName: String!) {\n  search(type: REPOSITORY, query: $repoName, first: 20) {\n    __typename\n    edges {\n      __typename\n      node {\n        __typename\n        ... on Repository {\n          name\n          description\n          languages(first: 1) {\n            __typename\n            nodes {\n              __typename\n              ... on Language {\n                name\n              }\n            }\n          }\n          stargazers {\n            __typename\n            totalCount\n          }\n        }\n      }\n    }\n  }\n}"

  public var repoName: String

  public init(repoName: String) {
    self.repoName = repoName
  }

  public var variables: GraphQLMap? {
    return ["repoName": repoName]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["type": "REPOSITORY", "query": GraphQLVariable("repoName"), "first": 20], type: .nonNull(.object(Search.selections))),
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

          public static func makeRepository(name: String, description: String? = nil, languages: AsRepository.Language? = nil, stargazers: AsRepository.Stargazer) -> Node {
            return Node(snapshot: ["__typename": "Repository", "name": name, "description": description, "languages": languages.flatMap { $0.snapshot }, "stargazers": stargazers.snapshot])
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
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("description", type: .scalar(String.self)),
              GraphQLField("languages", arguments: ["first": 1], type: .object(Language.selections)),
              GraphQLField("stargazers", type: .nonNull(.object(Stargazer.selections))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(name: String, description: String? = nil, languages: Language? = nil, stargazers: Stargazer) {
              self.init(snapshot: ["__typename": "Repository", "name": name, "description": description, "languages": languages.flatMap { $0.snapshot }, "stargazers": stargazers.snapshot])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
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