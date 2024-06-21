---
title: "안드로이드와 코틀린을 사용하여 모바일 애플리케이션에서 NFC 태그를 스캔하고 읽는 방법"
description: ""
coverImage: "/assets/img/2024-06-21-HowtoScanandReadNFCtagsinMobileapplicationusingAndroidKotlin_0.png"
date: 2024-06-21 20:44
ogImage: 
  url: /assets/img/2024-06-21-HowtoScanandReadNFCtagsinMobileapplicationusingAndroidKotlin_0.png
tag: Tech
originalTitle: "How to Scan and Read ***NFC tags*** in Mobile application using Android, Kotlin"
link: "https://medium.com/@meetjanani47/how-to-scan-and-read-nfc-tags-in-mobile-application-using-android-kotlin-dd31695b9a3e"
---



![image](/assets/img/2024-06-21-HowtoScanandReadNFCtagsinMobileapplicationusingAndroidKotlin_0.png)

- NFC 기술 소개
- 안드로이드 기기에서 NFC 태그 스캔 기능 활성화
- 안드로이드 프로젝트에 구현하는 기술 가이드 단계별 안내
- 테스트
- 결론

NFC(Near Field Communication)는 두 기기가 짧은 거리를 통해 무선으로 데이터를 교환할 수 있는 기술입니다.

NFC는 특히 모바일 기기에서 점점 인기를 끌고 있으며, 스마트폰과의 상호 작용 방식을 혁신적으로 바꿔놓았습니다. 또한, 접촉식 결제, 티켓 발권 및 출입 제어 등 다양한 애플리케이션에 사용될 수 있습니다.


<div class="content-ad"></div>

이 가이드에서는 NFC의 세계에 심취하고 Android 및 Kotlin을 사용하여 모바일 애플리케이션에서 NFC 태그를 스캔하는 방법을 알아보겠습니다. 초보자든 숙련된 개발자든 상관없이, 이 포괄적인 자습서는 NFC의 기능을 앱 개발 프로젝트에서 활용하기 위한 지식과 도구를 제공할 것입니다.

- 안드로이드 기기에서 NFC 태그를 활성화하려면 시스템 설정 -` 연결된 장치 -` 연결 기본값 -` NFC -` NFC 스위치를 켜십시오.
- 그러나 NFC 설정으로 이동하는 경로는 모바일 브랜드에 따라 다를 수 있습니다. 그럴 경우 시스템 설정의 검색 바에서 NFC를 간단히 검색하십시오.

![이미지](/assets/img/2024-06-21-HowtoScanandReadNFCtagsinMobileapplicationusingAndroidKotlin_1.png)

본 자습서에서는 Kotlin을 사용하여 Android 모바일 앱에서 NFC 태그를 스캔하는 방법에 대해 단계별로 안내하겠습니다.

<div class="content-ad"></div>

<img src="/assets/img/2024-06-21-HowtoScanandReadNFCtagsinMobileapplicationusingAndroidKotlin_2.png" />

안드로이드 앱에서 NFC를 사용하려면 AndroidManifest.xml 파일에 NFC 권한을 추가해야 합니다. 프로젝트의 AndroidManifest.xml 파일을 열고 아래와 같이 다음 줄을 추가하세요.

```javascript
<uses-permission android:name="android.permission.NFC"/>
```

NFC 태그를 읽으려면 NFC 어댑터 클래스의 인스턴스를 생성해야 합니다.

<div class="content-ad"></div>

getSystemService() 메소드를 사용하여 이 작업을 수행할 수 있습니다. 아래 코드를 Activity의 onCreate() 메소드에 추가해보세요.

```kotlin
private lateinit var nfcAdapter: NfcAdapter

override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    
    // 기본 NFC 어댑터 가져오기
    nfcAdapter = NfcAdapter.getDefaultAdapter(this)
}
```

NFC 인텐트 필터는 앱이 읽을 수 있는 NFC 태그의 종류를 지정하는 방법입니다. 아래 코드를 Activity에 추가하여 NFC 인텐트 필터를 생성할 수 있습니다.

```kotlin
private fun createNFCIntentFilter(): Array<IntentFilter> {
    val intentFilter = IntentFilter(NfcAdapter.ACTION_NDEF_DISCOVERED)
    try {
        intentFilter.addDataType("*/*")
    } catch (e: IntentFilter.MalformedMimeTypeException) {
        throw RuntimeException("MIME 유형 추가에 실패하였습니다.", e)
    }
    return arrayOf(intentFilter)
}
```

<div class="content-ad"></div>

NFC 태그가 감지되면 Android 시스템은 앱에 NFC 인텐트를 보냅니다.

NFC 인텐트를 처리하려면 Activity의 onNewIntent() 메소드를 오버라이드해야 합니다. 아래는 예시 코드 조각입니다.

```js
override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
}
```

앱이 화면에 표시될 때 NFC 인텐트를 받기 위해 foreground dispatch를 활성화해야 합니다.

<div class="content-ad"></div>

이것은 당신의 앱이 NFC 인텐트를 먼저 받고, 처리할지 다른 앱으로 전달할지를 결정할 수 있음을 의미합니다.

Foreground 디스패치를 활성화하려면, 액티비티의 onResume() 메서드를 재정의하고 enableForegroundDispatch()를 호출해야 합니다. 마찬가지로, onPause() 메서드를 재정의하고 액티비티가 전경에 없을 때 foreground 디스패치를 비활성화하기 위해 disableForegroundDispatch()를 호출해야 합니다.

다음은 foreground 디스패치를 활성화하고 비활성화하는 방법의 예시입니다:

```js
override fun onResume() {
    super.onResume()
    val nfcAdapter = NfcAdapter.getDefaultAdapter(this)
    val pendingIntent = PendingIntent.getActivity(
        this, 0, Intent(this, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), 0
    )
    val intentFilters = arrayOf<IntentFilter>(
        IntentFilter(NfcAdapter.ACTION_NDEF_DISCOVERED),
        IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED),
        IntentFilter(NfcAdapter.ACTION_TECH_DISCOVERED)
    )
    nfcAdapter.enableForegroundDispatch(this, pendingIntent, intentFilters, null)
}

override fun onPause() {
    super.onPause()
    val nfcAdapter = NfcAdapter.getDefaultAdapter(this)
    nfcAdapter.disableForegroundDispatch(this)
}
```

<div class="content-ad"></div>

onResume() 메서드에서는 기본 NfcAdapter를 가져와서 활동을위한 PendingIntent를 만듭니다. 또한 수신하려는 NFC 인텐트를 지정하는 IntentFilters 배열을 만듭니다. 그런 다음 NfcAdapter 인스턴스에 대해 enableForegroundDispatch()를 호출하고 PendingIntent 및 IntentFilters를 전달합니다.

onPause() 메서드에서는 NfcAdapter 인스턴스에서 disableForegroundDispatch()를 호출하여 전경 디스패치를 비활성화합니다.

전경 디스패치를 활성화 한 후에는 활동이 onNewIntent() 메서드에서 NFC 인텐트를 수신합니다. 그런 다음 NFC 태그 정보를 추출하고 적절히 처리할 수 있습니다.

```js
override fun onNewIntent(intent: Intent?) {
    super.onNewIntent(intent)
    if (intent?.action == NfcAdapter.ACTION_TAG_DISCOVERED) {
        val tag = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableExtra(NfcAdapter.EXTRA_TAG, Tag::class.java)
        } else {
            intent.getParcelableExtra(NfcAdapter.EXTRA_TAG)
        }
        tag?.id?.let {
            val tagValue = it.toHexString()
            Toast.makeText(this, "NFC tag detected: $tagValue", Toast.LENGTH_SHORT).show()
        }
    }
}
```

<div class="content-ad"></div>

이 예제에서는 NFC 인텐트가 ACTION_TAG_DISCOVERED인지 확인하여 NFC 태그가 감지되었는지 확인합니다. 그런 다음 getParcelableExtra() 메서드를 사용하여 인텐트에서 태그 객체를 추출하고 toHexString() 확장 함수를 사용하여 태그 ID를 16진수 문자열로 변환합니다. 마지막으로, 태그 ID와 함께 토스트 메시지를 표시합니다.

toHexString()이라는 확장 함수를 만들어 Tag ID를 16진수 문자열로 변환했습니다.

```kotlin
fun ByteArray.toHexString(): String {
    val hexChars = "0123456789ABCDEF"
    val result = StringBuilder(size * 2)

    map { byte ->
        val value = byte.toInt()
        val hexChar1 = hexChars[value shr 4 and 0x0F]
        val hexChar2 = hexChars[value and 0x0F]
        result.append(hexChar1)
        result.append(hexChar2)
    }

    return result.toString()
}
```

이제 NFC 스캔 기능을 구현했으니, 실제 장치에서 테스트해보는 시간입니다. 장치에서 NFC가 활성화되어 있고 근처에 NFC 태그가 있는지 확인하세요. 앱을 실행하고 NFC 태그를 장치에 가까이 가져가보세요. 태그 ID가 표시된 토스트 메시지가 나타날 것입니다.

<div class="content-ad"></div>

축하합니다! 안드로이드 앱에 NFC 스캔 기능을 성공적으로 구현하셨다고 가정합니다.

![NFC scanning](/assets/img/2024-06-21-HowtoScanandReadNFCtagsinMobileapplicationusingAndroidKotlin_3.png)

이 블로그 포스트를 여기까지 읽어 주셔서 감사합니다. 이제 NFC 스캔 기능을 성공적으로 달성하셨다고 생각합니다. 그러나 의문 사항이 있으면 언제든지 알려주세요. 언제든지 도와드릴 수 있어 기뻐요.

저는 글을 쓰는 만큼 여러분이 읽는 것을 즐길 수 있기를 바랍니다.
이 튜토리얼이 누군가에게 도움이 될 것으로 생각하시나요? 망설이지 말고 공유해주세요. 이가 도움이 되기를 바라며, 50번까지 클랩 버튼을 눌러 주세요. 감사합니다.