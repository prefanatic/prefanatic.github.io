import 'dart:async';

import 'package:gql_http_link/gql_http_link.dart';

import 'package:graphql/client.dart';

final link = HttpLink(
  'https://api.github.com/graphql',
);

const _githubToken = String.fromEnvironment('GITHUB_TOKEN', defaultValue: '');

final authLink = AuthLink(
  getToken: () async => 'Bearer $_githubToken',
);

final client = GraphQLClient(
  cache: GraphQLCache(),
  link: authLink.concat(link),
);

final query = r'''
query AllCommits($owner: String!, $name: String!, $after: String) {
  repository(owner: $owner, name: $name) {
    branch1: ref(qualifiedName: "master") {
      target {
        ... on Commit {
          history(first: 100, after: $after) {
            ...CommitFragment
          }
        }
      }
    }
  }
}

fragment CommitFragment on CommitHistoryConnection {
  totalCount
  nodes {
    oid
    message
    committedDate
    author {
      name
      email
    }
  }
  pageInfo {
    hasNextPage
    endCursor
  }
}
''';

Future<void> main(List<String> arguments) async {
  final dates = <DateTime>[];

  String? after;
  while (true) {
    final options = QueryOptions(document: gql(query), variables: {
      'owner': 'maalox',
      'name': 'digihaler-flutter',
      'after': after,
    });

    final result = await client.query(options);

    final history = result.data!['repository']['branch1']['target']['history'];
    final bool hasNextPage = history['pageInfo']['hasNextPage'];
    if (!hasNextPage) {
      break;
    }

    after = history['pageInfo']['endCursor'];
    final List<Object?> nodes = history['nodes'];

    nodes.cast<Map<String, dynamic>>().forEach((item) {
      dates.add(DateTime.parse(item['committedDate']));
    });
  }

  dates.sort();

  print(dates);
}
