# DHT22 with API example / DHT22 ejemplo con API

Proyecto de arduino para ESP32 S3 que implementa una api para hacer peticiones bajo demanda de lecturas a un sensor DHT22 conectado en el pin 15
Este archivo ha sido creado como parte de un proyecto de medición de humedad y temperatura documentado en el canal de youtube https://www.youtube.com/@ChispyDev/featured

## Configuraciones necesarias

Es necesario configurar las variables de ssid y password con las credenciales de wifi. Es necesario que tanto el dispositivo que realice la petición como el ESP32 usen esa misma wifi.

Si se han mantenido las configuraciones de ip local y endpoint el sistema será accesible desde http://192.168.1.202/data 
