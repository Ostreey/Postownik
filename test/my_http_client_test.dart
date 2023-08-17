import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:postownik/aplication/core/my_http_client.dart';
import 'package:postownik/data/endpoints/facebook_endpoints.dart';
import 'package:postownik/data/exceptions/exceptions.dart';

import 'my_http_client_test.mocks.dart';
@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  late MockClient mockClient;
  late MyHttpClient myHttpClient;

  setUp(() {
    mockClient = MockClient();
    myHttpClient = MyHttpClient(client: mockClient);
  });

  group(MyHttpClient, () {
    group("should return json decode", () {
      test('when client response was 200 and has a valid data', () async{
        const response =
            '{"access_token":"test","token_type":"test","expires_in":1234}';
        when(mockClient
            .get(Uri.parse('www.test.com'), headers: {
          'content-type': 'application/json',
        })).thenAnswer((_) async => Response(response, 200));

        final result = await myHttpClient.get('www.test.com');
        expect(result, {
          "access_token": "test",
          "token_type": "test",
          "expires_in": 1234
        });
      });
    });
    group('should throw', () {
      test('a ServerException when Client response was not 200', () {
        when(mockClient
            .get(Uri.parse(Endpoints.LONGLIVE_ACCESS_TOKEN + 'test'), headers: {
          'content-type': 'application/json',
        })).thenAnswer((_) async => Response('', 201));

        expect(() => myHttpClient.get(Endpoints.LONGLIVE_ACCESS_TOKEN + 'test'),
            throwsA(isA<ServerException>()));
      });
    });
  });
}
