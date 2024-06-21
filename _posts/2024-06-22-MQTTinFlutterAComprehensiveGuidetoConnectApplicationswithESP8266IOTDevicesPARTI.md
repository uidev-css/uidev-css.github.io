---
title: "Flutter에서 MQTT로 ESP8266 IOT 기기 연결하는 방법 종합 가이드  PART I"
description: ""
coverImage: "/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_0.png"
date: 2024-06-22 05:09
ogImage: 
  url: /assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_0.png
tag: Tech
originalTitle: "MQTT in Flutter: A Comprehensive Guide to Connect Applications with ESP8266 IOT Devices — PART I"
link: "https://medium.com/@punnyarthabanerjee/mqtt-in-flutter-a-comprehensive-guide-to-connect-applications-with-esp8266-iot-devices-part-i-5274ccc5874e"
---


요즘에는 많은 IOT 기기들과 작업하고 있어요. 많은 기기들을 다루는 데 큰 어려움이 있어요. 운영, 데이터 수집, 유지관리 등을 모두 집중적으로 하기가 어려워요.

![이미지](/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_0.png)

## 리얼타임 기기들이 클라우드와 어떻게 소통할 수 있는 가장 좋은 방법은 무엇인가요?

![이미지](/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_1.png)

<div class="content-ad"></div>

# MQTT 프로토콜에 대해 알아봐요!!!!!!!!

이 글에서는 다음의 내용을 다룹니다.

- MQTT 브로커와의 ESP8266 연결
- MQTT 브로커와의 Flutter 연결

가이드를 두 부분으로 나눴어요.

<div class="content-ad"></div>

첫 번째 파트에서는 우리의 브로커와 Esp8266을 구성하는 방법에 대해 다룹니다.

두 번째 파트에서는 어플리케이션에서 데이터를 읽고 쓰는 방법에 대해 다룹니다.

## MQTT 브로커란 무엇인가요?

아키텍처 사이에서 중개자 역할을 한다고 생각해보세요. Esp8266 장치는 데이터를 브로커로 보내고, 거기서 데이터가 저장됩니다. 그런 후 어플리케이션은 MQTT 브로커에 연결하여 데이터에 접근할 수 있습니다.

<div class="content-ad"></div>

![2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_2.png](/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_2.png)

**참고:** 대부분의 경우, 데이터를 처리하기 위해 백엔드가 필요하고 응용 프로그램이 이에 액세스하지만, MQTT를 사용하여 연결하고 데이터를 보내는 방법을 알고 나면 쉽다는 것을 이 문서에서 다루지는 않습니다. 나중에 전체 IOT 인프라를 보여주는 글을 쓸 수도 있습니다.

# 준비물

- MQTT의 이해
- 발행/구독 아키텍처의 기본 이해
- ESP8266 Node MCU 모듈
- Flutter 또는 다른 기본 프레임워크에 대한 이해

<div class="content-ad"></div>


![image](/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_3.png)

# 파트 1: 설정

전체 아키텍처를 구현하려면 먼저 MQTT 브로커가 필요합니다. HiveMQ와 EMQX와 같은 많은 무료 브로커들이 있으며 Mosquitto를 사용하여 로컬 브로커를 만들 수도 있습니다.

![image](/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_4.png)


<div class="content-ad"></div>

EMQX에 계정을 등록하고 브로커를 생성했습니다.

![이미지](/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_5.png)

그런 다음 브로커에 액세스하는 데 사용될 몇 가지 사용자 계정을 만듭니다.

![이미지](/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_6.png)

<div class="content-ad"></div>

# Part 2: ESP8266 펌웨어

펌웨어 작업을 시작하기 전에 몇 가지 알아야 할 사항이 있습니다.

웹에서 MQTT 브로커에 액세스할 때 TLS를 사용하거나 사용하지 않을 수 있습니다. 제 경험상 TLS를 사용하지 않고 브로커에 연결하려고 시도하면 Esp8266에서 작동하지 않습니다. 모든 연결 요청이 거부됩니다. 따라서 저는 연결을 가장 안전하게 만드는 방법을 보여드리겠습니다.

- 브로커에서 인증서를 다운로드하십시오 (나중에 필요할 것입니다)

<div class="content-ad"></div>


![image](/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_7.png)

- Arduino IDE를 열고 Esp8266을 설정합니다.

Esp8266을 사용해본 적이 없다면, 이 가이드를 따를 수 있습니다.

우선 라이브러리를 가져오겠습니다.


<div class="content-ad"></div>

```js
#include <ESP8266WiFi.h>

#include <PubSubClient.h>

// 이 부분은 선택 사항입니다. 센서 데이터로 보낼 무작위 숫자를 생성하기 위해 사용했습니다.
#include <ESP8266TrueRandom.h>

// 인터넷과의 시간 동기화에 사용됩니다.
#include <time.h>
```

이제 자격 증명을 정의해 봅시다.

```js
const char *ntp_server = "0.pool.ntp.org";     // 기본 NTP 서버
const long gmt_offset_sec = 0;            // GMT 오프셋(시간대에 맞게 조정)
const int daylight_offset_sec = 0;        // 일광 절약 시간 오프셋(초)

const char* SSID = "************";
const char* PASSWORD = "************";

const char* MQTT_HOST = "************"; // 브로커 대시보드에서 가져오세요
const int MQTT_PORT = 8883; // 기본 MQTT TCP TLS 포트

const char* MQTT_USERNAME = "";
const char* MQTT_PASSWORD = "";
const char* MQTT_TOPIC = "test";

char payload[10] = "";

BearSSL::WiFiClientSecure espClient;

PubSubClient mqtt_client(espClient);
```

이제 다운로드한 인증서 데이터를 입력해 봅시다. 텍스트 편집기로 해당 파일을 열어 내용을 복사하세요.

<div class="content-ad"></div>

다음은 Markdown 형식으로 table 태그를 변경해주세요.

```js
static const char ca_cert[] = R"EOF(
|-----BEGIN CERTIFICATE-----|
|---MIIDrzCCApegAwIBAgIQCDvgVpBCRrGhdWrJWZHHSjANBgkqhkiG9w0BAQUFADBh---|
|---MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3---|
|---d3cuZGlnaWNlcnQuYa9tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBD---|
|-----END CERTIFICATE-----|
)EOF";
```

먼저, WiFi에 연결해야 합니다.

```js
void connectToWiFi() {
    WiFi.begin(SSID, PASSWORD);
    Serial.print("WiFi에 연결 중");
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("\nWiFi 네트워크에 연결되었습니다");
}
```

<div class="content-ad"></div>

우리의 Esp8266과 시간을 동기화하기 위해 NTP(Network Time Protocol) 서버를 사용합니다.

```js
void syncTime() {
    configTime(gmt_offset_sec, daylight_offset_sec, ntp_server);
    
    Serial.print("NTP 시간 동기화를 기다리는 중: ");

    while (time(nullptr) < 8 * 3600 * 2) {
        delay(1000);
        Serial.print(".");
    }

    Serial.println("시간이 동기화되었습니다.");
    
    struct tm timeinfo;
    
    if (getLocalTime(&timeinfo)) {
        Serial.print("현재 시간: ");
        Serial.println(asctime(&timeinfo));
    
    } else {
        Serial.println("로컬 시간을 가져오지 못했습니다.");
    }
}
```

브로커에 연결하려면 다음 함수를 사용할 것입니다.

```js
void connectToMQTTBroker() {
    
    // 우리의 인증서를 사용하여 신뢰할 수 있는 연결 요청을 수행합니다
    BearSSL::X509List serverTrustedCA(ca_cert);

    espClient.setTrustAnchors(&serverTrustedCA);

    while (!mqtt_client.connected()) {

        String client_id = "esp8266-client-" + String(WiFi.macAddress());
        
        Serial.printf("%s로 MQTT 브로커에 연결 중.....\n", client_id.c_str());
        
        if (mqtt_client.connect(client_id.c_str(), MQTT_USERNAME, MQTT_PASSWORD)) {
            
            Serial.println("MQTT 브로커에 연결되었습니다.");
        
        } else {
            char err_buf[128];
            
            espClient.getLastSSLError(err_buf, sizeof(err_buf));
            
            Serial.print("MQTT 브로커에 연결에 실패했습니다. rc=");
            Serial.println(mqtt_client.state());
            Serial.print("SSL 오류: ");
            Serial.println(err_buf);

            delay(5000);
        }
    }
}
```

<div class="content-ad"></div>

해당 함수를 사용하여 주제에 대한 데이터를 게시합니다.

```js
void publishData(int data){
  // Int 데이터를 String으로 변환합니다.
  itoa(data, payload, 10);

  // 주제 "test"에 데이터를 게시합니다.
  mqtt_client.publish(MQTT_TOPIC, payload);
}
```

이벤트에 구독하려면 다음과 같이 작성합니다.

```js
void subscribeToTopic(char* topic){

  mqtt_client.subscribe(topic);
  Serial.print("주제에 구독함: ");
  Serial.println(topic);
}
```

<div class="content-ad"></div>

구독한 주제를 듣습니다.

```js
void mqttCallback(char *topic, byte *payload, unsigned int length) {
    Serial.print("주제에서 메시지 받음: ");
    Serial.println(topic);
    Serial.print("메시지:");
    for (unsigned int i = 0; i < length; i++) {
        Serial.print((char) payload[i]);
    }
    Serial.println();
    Serial.println("-----------------------");
}
```

마지막으로 전체 펌웨어 코드를 작성해 봅시다.

```js
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <ESP8266TrueRandom.h>
#include <time.h>

// NTP 서버 설정
const char *ntp_server = "0.pool.ntp.org";     // 기본 NTP 서버
const long gmt_offset_sec = 0;            // GMT 오프셋(시간대에 따라 조정)
const int daylight_offset_sec = 0;        // 일광 절약 시간 오프셋(초)

const char* SSID = "본인의 와이파이를 사용해주세요";
const char* PASSWORD = "패스워드";

const char* MQTT_HOST = "f4b0e072.ala.asia-southeast1.emqxsl.com";
const int MQTT_PORT = 8883;

const char* MQTT_USERNAME = "test2";
const char* MQTT_PASSWORD = "testpass123A";
const char* MQTT_TOPIC = "test";

char payload[10] = "";

static const char ca_cert[] = R"EOF(
-----BEGIN CERTIFICATE-----
여기에 인증서 내용을 복사하세요
-----END CERTIFICATE-----
)EOF";

BearSSL::WiFiClientSecure espClient;
PubSubClient mqtt_client(espClient);

void subscribeToTopic(char* topic){

  mqtt_client.subscribe(topic);
  Serial.print("주제에 구독 완료: ");
  Serial.println(topic);
}

void mqttCallback(char *topic, byte *payload, unsigned int length) {
    Serial.print("주제에서 받은 메시지: ");
    Serial.println(topic);
    Serial.print("메시지:");
    for (unsigned int i = 0; i < length; i++) {
        Serial.print((char) payload[i]);
    }
    Serial.println();
    Serial.println("-----------------------");
}

void connectToMQTTBroker() {
    
    // 인증서를 사용하여 신뢰할 수 있는 연결 요청을 수행합니다
    BearSSL::X509List serverTrustedCA(ca_cert);

    espClient.setTrustAnchors(&serverTrustedCA);

    while (!mqtt_client.connected()) {

        String client_id = "esp8266-client-" + String(WiFi.macAddress());
        
        Serial.printf("%s로 MQTT 브로커에 연결 중.....\n", client_id.c_str());
        
        if (mqtt_client.connect(client_id.c_str(), MQTT_USERNAME, MQTT_PASSWORD)) {
            
            Serial.println("MQTT 브로커에 연결됨");

            subscribeToTopic("test");
        
        } else {
            char err_buf[128];
            
            espClient.getLastSSLError(err_buf, sizeof(err_buf));
            
            Serial.print("MQTT 브로커에 연결 실패, 상태=");
            Serial.println(mqtt_client.state());
            Serial.print("SSL 오류: ");
            Serial.println(err_buf);

            delay(5000);
        }
    }
}

void syncTime() {
    configTime(gmt_offset_sec, daylight_offset_sec, ntp_server);
    
    Serial.print("NTP 시간 동기화 대기 중: ");

    while (time(nullptr) < 8 * 3600 * 2) {
        delay(1000);
        Serial.print(".");
    }

    Serial.println("시간 동기화 완료");
    
    struct tm timeinfo;
    
    if (getLocalTime(&timeinfo)) {
        Serial.print("현재 시간: ");
        Serial.println(asctime(&timeinfo));
    
    } else {
        Serial.println("로컬 시간 획득 실패");
    }
}

void publishData(int data){
  // 정수 데이터를 문자열로 변환합니다
  itoa(data,payload,10);

  // "test" 주제에 데이터를 발행합니다
  mqtt_client.publish(MQTT_TOPIC,payload);
}


void connectToWiFi() {
    WiFi.begin(SSID, PASSWORD);
    Serial.print("WiFi에 연결 중");
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("\nWiFi 네트워크에 연결됨");
}


void setup() {
  Serial.begin(115200);

  connectToWiFi();

  syncTime();

  mqtt_client.setServer(MQTT_HOST,MQTT_PORT);

  connectToMQTTBroker();

}

void loop() {
  if (!mqtt_client.connected()) {
        connectToMQTTBroker();
    }


    mqtt_client.loop();

    // 3초마다 무작위 숫자를 보냅니다. 여러분은 센서 데이터를 전송할 수 있습니다.
    publishData(ESP8266TrueRandom.random(1,500));
    delay(3000);

}
```

<div class="content-ad"></div>

마침내, 코드를 Esp8266에 업로드하세요.

mqtt-cli를 설치하고 컴퓨터 터미널에서 실행하여 데이터가 발행되는지 확인하세요.

설치 후, 다음 명령어를 실행하세요

```js
mqtt sub -h <호스트> -p <포트> -s -u <사용자이름> -pw <비밀번호> -t <토픽>
```

<div class="content-ad"></div>

우리 경우에는 "test" 주제입니다.

다음 출력을 볼 수 있습니다.


<img src="/assets/img/2024-06-22-MQTTinFlutterAComprehensiveGuidetoConnectApplicationswithESP8266IOTDevicesPARTI_8.png" />


이것은 우리의 Esp8266이 데이터를 MQTT 브로커로 보내고, 우리 컴퓨터에서 실행되는 CLI 도구를 사용하여 해당 데이터를 구독한다는 것을 보여줍니다.

<div class="content-ad"></div>

# 마지막으로

MQTT를 Esp8266 및 Flutter와 함께 사용하는 방법에 대한 두 부분 가이드의 첫 번째 부분이 끝났습니다.

소중한 시간 내주셔서 감사합니다. 이에 대한 생각을 알려주세요!

도움이 되었다면 LinkedIn에서 제 소식을 지켜보실 수도 있습니다.

<div class="content-ad"></div>

![Animated GIF](https://miro.medium.com/v2/resize:fit:440/0*xIWi3szlPmvPpqh0.gif)