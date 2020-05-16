public class AnimalLocator {
    
    public String getAnimalNameById(Integer id)
    {

        Http http = new Http();
        HttpRequest httpRequest =  new HttpRequest();
        HttpResponse httpResponse = new HttpResponse();

        String endpoint = 'https://th-apex-http-callout.herokuapp.com/animals/:'+id;
        httpRequest.setEndpoint(endpoint);
        httpRequest.setMethod('GET');

        httpResponse = http.send(httpRequest);
        System.debug('response from server --->' +httpResponse);
        if(httpResponse.getStatusCode() == 200 )
        {
            map<String,Object> result = (map<String,Object>) JSON.deserializeUntyped(httpResponse.getBody());
           map<String,Object> animals = (map<String,Object>) result.get('animal');
            System.debug('Animals map ---->' +animals);

            String str = String.valueOf(animals.get('name'));
            System.debug(' str- -->' +str);
            return str;
        }
        
        
        return null;
    }

}