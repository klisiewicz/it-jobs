import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';

TypeMatcher<QueryOptions> usesQueryDocument(String document) {
  return const TypeMatcher<QueryOptions>().having(
    (options) => options.document,
    'document',
    equals(gql(document)),
  );
}
