# Registreringsapplikation

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

# API Dokumentation

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


