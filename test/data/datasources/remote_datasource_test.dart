import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:postownik/aplication/core/my_http_client.dart';
import 'package:postownik/data/datasources/remote_datasource.dart';
import 'package:postownik/data/endpoints/facebook_endpoints.dart';
import 'package:postownik/data/models/fb_pages_model/fb_pages_model.dart';

import 'remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MyHttpClient>()])
void main() {
  late MockMyHttpClient mockMyHttpClient;
  late RemoteDatasourceImpl remoteDatasourceImplUnderTest;

  setUp(() {
    mockMyHttpClient = MockMyHttpClient();
    remoteDatasourceImplUnderTest =
        RemoteDatasourceImpl(client: mockMyHttpClient);
  });
  group('RemoteDatasource', () {
    // Test for getPagesFromApi method
    test('getPagesFromApi returns FbPagesModel', () async {
      Map<String, dynamic> expectedResponse = {
       'data': [
         {
           'name': 'Postownik',
           'access_token': 'token1',
           'id': '1',
           "picture": {
             "data": {
               "url": "url1"
             }
           },
         }
       ]
      };
      final accessToken = 'your_access_token_here';
      when(mockMyHttpClient.get(any)).thenAnswer((_) async => expectedResponse);
      final result =
          await remoteDatasourceImplUnderTest.getPagesFromApi(accessToken);

      final expectedModel = FbPagesModel(data: [
        FbPagePropertiesModel(
          name: 'Postownik',
          pageAccessToken: 'token1',
          id: '1',
          picUrl: 'url1',
        ),
      ]); // Expected model

      expect(result, equals(expectedModel));
      verify(mockMyHttpClient.get(Endpoints.PAGES + accessToken));
      verifyNoMoreInteractions(mockMyHttpClient);
    });
  });
}
