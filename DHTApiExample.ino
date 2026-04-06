#include <WiFi.h>
#include <WebServer.h>
#include <HTTPClient.h>
#include "DHT.h"
#include <time.h>

// ===== WIFI =====
const char* ssid = "";
const char* password = "";

IPAddress local_IP(192, 168, 1, 202);
IPAddress gateway(192, 168, 1, 1);
IPAddress subnet(255, 255, 255, 0);
IPAddress primaryDNS(8,8,8,8);    // Google DNS
IPAddress secondaryDNS(8,8,4,4);  // Google DNS

// ===== DHT =====
#define DHTPIN 15     
#define DHTTYPE DHT22   
DHT dht(DHTPIN, DHTTYPE);

// ===== SERVER =====
WebServer server(80);

// ===== TIME =====
const char* ntpServer = "pool.ntp.org";
const long  gmtOffset_sec = 3600;
const int   daylightOffset_sec = 3600;
bool timeAvailable = false;

// ===== TEST INTERNET =====
bool checkInternet() {
  HTTPClient http;
  http.begin("http://clients3.google.com/generate_204");
  int httpCode = http.GET();
  http.end();
  return (httpCode == 204);
}


void handleRead() {
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  if (isnan(h) || isnan(t)) {
    server.send(500, "application/json", "{\"error\":\"Sensor failure\"}");
    return;
  }

  char timeString[30];

  if(timeAvailable){
    struct tm timeinfo;
    if(getLocalTime(&timeinfo)){
      strftime(timeString, sizeof(timeString), "%Y-%m-%d %H:%M:%S", &timeinfo);
    } else {
      strcpy(timeString, "N/A");
    }
  } else {
    strcpy(timeString, "NO_INTERNET");
  }

  String json = "{";
  json += "\"temperature\":" + String(t, 2) + ",";
  json += "\"humidity\":" + String(h, 2) + ",";
  json += "\"timestamp\":\"" + String(timeString) + "\"";
  json += "}";

  server.send(200, "application/json", json);
}

void setup() {
  Serial.begin(9600);
  dht.begin();

  // IP fija
  if (!WiFi.config(local_IP, gateway, subnet, primaryDNS, secondaryDNS)) {
    Serial.println("Configuración de IP estática fallida");
  }
  WiFi.begin(ssid, password);

  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nWiFi OK");
  Serial.println(WiFi.localIP());

  // ===== TEST INTERNET =====
  Serial.println("Checking internet...");
  if(checkInternet()){
    Serial.println("Internet OK");

    configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);

    struct tm timeinfo;
    int retries = 0;

    while(!getLocalTime(&timeinfo) && retries < 20){
      Serial.print(".");
      delay(500);
      retries++;
    }

    if(retries < 20){
      Serial.println("NTP OK");
      timeAvailable = true;
    } else {
      Serial.println("NTP FAILED");
    }

  } else {
    Serial.println("NO INTERNET ACCESS");
  }

  // API
  server.on("/data", HTTP_GET, handleRead);
  server.begin();
}

void loop() {
  server.handleClient();
}