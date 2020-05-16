/**
 * Created by abhishek on 26/3/18.
 */
@isTest
global class AnimalLocatorTest{
    global HttpResponse response(HttpRequest request)
    {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content Type','application/json');
        response.setBody('{"animal":"id":!,"name":"cow","eats":"grass"}');
        response.setStatusCode(200);
        return  response;

    }

}