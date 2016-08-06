# Registreringsapplikation - Laboration 1

### Instruktioner

- ``` git clone https://github.com/jb223cp/1DV450_jb223cp.git ```
- Från mapp i vilken befinner sig applikation kör : ``` cd Registration ``` 
- ``` bundle install ```
- ``` gem install tzinfo-data ```
- ``` rake db:migrate```
- ``` rake db:seed```  Skapar en användare med admin rättigheter, och en användare med vanliga rättigheter
- ``` rails s -b $IP -p $PORT ``` i Cloud9 IDE eller ``` rails s  -b 0.0.0.0 ``` om applikationen ska köras lokalt

##### Administrator rättigheter:
USERNAME: admin
PASSWORD: test

##### Användare rättigheter:
USERNAME: calle
PASSWORD: test1

Lycka till!

# API Dokumentation - Laboration 2

### Baslänk till API

``` 
https://rubyonrails-api-jb223cp.c9users.io/api/v1/ 
```

### API nyckel

Vid varje anrop måste en gilltig  API nyckel skickas.
Ett exempel av gilltig apikey:

``` 
pubs?akey=newtoken 
```

Hela anrop:

``` 
https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs?akey=newtoken 
```

Resultatet går att få ut i JSON format.

### Autentisering

För att använda CRUD funktionalitet behövs gilltig JWT Token.
JWT Token når du på följande sätt:
- Skicka ett POST anrop på följande adress:

``` 
https://rubyonrails-api-jb223cp.c9users.io/knock/auth_token
```

I _body_ av anropet skicka följande inloggningsuppgifter (Uppgifterna finns i seed.db file):

``` 
{"auth":{"name": "selma", "password": "selma2"}}
```
- Du bör få Status 201 Created vid följande JSON svar:
``` 
{
  "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0NzAyNDU3OTQsImF1ZCI6ZmFsc2UsInN1YiI6Mn0.9XiJ3paZKRI9k8W4vpH0WInTAmwYhxVWAeibTvRO6c0"
}
``` 
- Detta är token vilken behövs inkludera i sådana anrop som behövs autentisering (förklarad vidare i texten)
- Anropet från Postman
<img width="924" alt="screen shot 2016-08-02 at 19 47 21" src="https://cloud.githubusercontent.com/assets/8629282/17338998/1ab75e04-58ea-11e6-81c6-206e18684c69.png">

### Exempel med GET anrop

 GET Alla pubar:
 
 ``` 
 https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs?akey=newtoken
 ``` 
 
 GET Pub med id=1
 
 ``` 
 https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs/1?akey=newtoken
 ``` 
 
 GET OFFSET
 
  ``` 
  https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs?offset=2&akey=newtoken
  ``` 
  
 GET LIMIT
 
  ``` 
  https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs?limit=2&akey=newtoken
  ``` 
  
  GET LIMIT och OFFSET
  
  ``` 
  https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs?offset=1&limit=2&akey=newtokenhttps://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs?limit=2&akey=newtoken
  ``` 
  
  GET Pub med creator_id=1
 
  ``` 
  https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs?creator_id=1&akey=newtoken
  ``` 
  
  GET pubar med latitude och longitude
  
  ``` 
  https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs?latitude=13&&longitude=55&akey=newtoken
  ``` 
  
###Exempel med POST anrop
  
  POST create pub med autentisering
  
  <img width="919" alt="screen shot 2016-08-02 at 21 00 41" src="https://cloud.githubusercontent.com/assets/8629282/17341751/55a752e2-58f6-11e6-97cc-459b08738962.png">
  
  POST create pub med rätt JSON
  
###Exempel med DELETE anrop
   
  DELETE pub
  
  Radera puben med id = 3
  Det går att testa med något id utan motsvarande pub (t.ex. 55) och observera fel meddelande.
  Gilltig akey och auth token är obligatoriska.
  
  ``` 
  https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs/3?akey=newtoken
  ``` 
  
###Exempel med PUT anrop

Uppdatera puben med id=2
Gilltig akey och auth token är obligatoriska.

  ``` 
  https://rubyonrails-api-jb223cp.c9users.io/api/v1/pubs/3?akey=newtoken
  ``` 
  
Exempel på JSON som skickad i body:

   ``` 
  {
    "pub": {
        "name": "Updated Pub2"
    }
  }
  ``` 
  

  
  

