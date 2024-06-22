---
title: "Django에서 Auth User 회원가입 및 로그인 기능 구현하는 방법"
description: ""
coverImage: "/assets/img/2024-06-22-DjangoAuthUserSignupandLogin_0.png"
date: 2024-06-22 15:59
ogImage: 
  url: /assets/img/2024-06-22-DjangoAuthUserSignupandLogin_0.png
tag: Tech
originalTitle: "Django Auth User Signup and Login"
link: "https://medium.com/@devsumitg/django-auth-user-signup-and-login-7b424dae7fab"
---


아래는 Django Best Practices에 대한 이전 블로그를 확인해보세요: Tips for Writing Better Code.

# 소개

사용자 인증과 권한 부여는 웹 애플리케이션에서 중요한 구성 요소입니다. 인기 있는 Python 웹 프레임워크인 Django는 사용자 로그인 및 가입 기능을 구현하기 위한 강력한 기능을 제공합니다.

<div class="content-ad"></div>

이 블로그 포스트에서는 Django 및 HTML 폼을 사용하여 사용자 로그인 및 가입 시스템을 만드는 방법을 살펴보겠습니다. 이 기능을 Django 프로젝트에 성공적으로 구현하는 데 도움이 되는 필수 단계를 다루고 유용한 리소스를 제공할 것입니다.

## 그러니까, 간단한 애플리케이션을 만들어 봅시다 👍

# 준비물

이 자습서에 들어가기 전에 다음의 준비물이 갖춰져 있는지 확인하십시오:

<div class="content-ad"></div>

- Python 및 Django Framework의 기본적인 이해
- 시스템에 설치된 Python (버전 3.6 이상) 및 pip
- Django 프레임워크와 그 개념에 익숙함

[참고: Virtual Environment를 활용하세요. 👍]

# 단계

# 1. Django 프로젝트 설정하기

<div class="content-ad"></div>

우리 간단한 애플리케이션을 만들기 위해서는 새 Django 프로젝트를 설정해야 합니다. 설치 프로세스 및 프로젝트 초기화에 대해 다룰 것입니다.

시작하려면 다음 단계를 따라 Django 프레임워크를 설정하세요:

pip를 사용하여 Django 프레임워크를 설치합니다:

```js
pip install django
```

<div class="content-ad"></div>

새로운 Django 프로젝트를 만들어보세요:

```js
django-admin startproject myproject
```

프로젝트 내에 새로운 Django 앱을 만들어보세요:

```js
cd myproject
python manage.py startapp myapp
```

<div class="content-ad"></div>

# 2. Django 설정 구성하기

당신의 Django 프로젝트의 settings.py 파일을 열고 다음 코드를 작성해주세요:

```js
INSTALLED_APPS = [
    # ...
    # ..
    # .
    # 👇 1. 이 줄을 추가해주세요
    'myapp',
]

TEMPLATES = [
    {
        # 👇 2. 이 줄을 추가해주세요 
        'DIRS': ['templates'],
        
    },
]
```

# 3. URL 추가하기

<div class="content-ad"></div>

이제 myapp URL에 접근하려면 myproject/urls.py 파일에 다음 줄을 추가해야 합니다.

myproject 폴더 안의 urls.py 파일을 열고 다음 코드를 작성하세요:

```python
from django.contrib import admin
from django.urls import path, include # 👈 1. 이 줄 추가

urlpatterns = [
    path('admin/', admin.site.urls),
    # 👇 2. 이 곳에 앱 URL 추가
    path('', include('myapp.urls'))
]
```

뷰의 URL 구성:

<div class="content-ad"></div>

myapp 폴더 안에 urls.py 파일을 생성하고 아래 코드를 작성하세요:

```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='home'),
    path('login/', views.user_login, name='login'),
    path('signup/', views.user_signup, name='signup'),
    path('logout/', views.user_logout, name='logout'),
]
```

- urlpatterns: 어플리케이션의 URL 패턴을 보유하는 리스트입니다. 각 URL 패턴은 리스트의 요소로 정의됩니다.
- path('', views.index, name='home'): 이 줄은 어플리케이션의 홈페이지에 대한 URL 패턴을 정의합니다. 빈 문자열 ``은 루트 URL을 나타냅니다. views.index는 뷰 모듈의 index 함수가 홈페이지를 렌더링하는 데 사용됨을 나타냅니다. name='home'은 이 URL 패턴에 이름을 할당하는 선택적 매개변수로, 다른 코드의 다른 부분에서 이 URL 패턴을 참조하는 데 사용할 수 있습니다.
- path('login/', views.user_login, name='login'): 이 줄은 로그인 페이지에 대한 URL 패턴을 정의합니다. `login/` 문자열은 URL 경로 /login/을 나타냅니다. views.user_login은 뷰 모듈의 user_login 함수가 로그인 페이지를 렌더링하는 데 사용됨을 나타냅니다. name='login'은 이 URL 패턴에 이름을 할당합니다.
- path('signup/', views.user_signup, name='signup'): 이 줄은 가입 페이지에 대한 URL 패턴을 정의합니다. `signup/` 문자열은 URL 경로 /signup/을 나타냅니다. views.user_signup은 뷰 모듈의 user_signup 함수가 가입 페이지를 렌더링하는 데 사용됨을 나타냅니다. name='signup'은 이 URL 패턴에 이름을 할당합니다.
- path('logout/', views.user_logout, name='logout'): 이 줄은 로그아웃 페이지에 대한 URL 패턴을 정의합니다. `logout/` 문자열은 URL 경로 /logout/을 나타냅니다. views.user_logout은 뷰 모듈의 user_logout 함수가 로그아웃 페이지를 렌더링하는 데 사용됨을 나타냅니다. name='logout'은 이 URL 패턴에 이름을 할당합니다.

이러한 URL 패턴은 사용자가 입력한 URL과 해당 페이지를 렌더링하는 데 사용되어야 하는 뷰 사이의 매핑을 결정합니다. 이 경우, 뷰 모듈에는 index, user_login, user_signup, user_logout 등의 함수가 포함되어 있으며, 각 페이지의 렌더링을 처리합니다.

<div class="content-ad"></div>

# 5. 뷰 함수 추가

myapp 폴더 내의 views.py 파일을 열고 아래 코드를 작성하여 템플릿을 표시하고 리다이렉션합니다:

```python
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from .forms import SignupForm, LoginForm

# 여기서 뷰 함수를 생성합니다.
# 홈 페이지
def index(request):
    return render(request, 'index.html')

# 회원 가입 페이지
def user_signup(request):
    if request.method == 'POST':
        form = SignupForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')
    else:
        form = SignupForm()
    return render(request, 'signup.html', {'form': form})

# 로그인 페이지
def user_login(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(request, username=username, password=password)
            if user:
                login(request, user)
                return redirect('home')
    else:
        form = LoginForm()
    return render(request, 'login.html', {'form': form})

# 로그아웃 페이지
def user_logout(request):
    logout(request)
    return redirect('login')
```

제공된 코드 조각은 사용자 인증과 계정 관리를 위한 다양한 뷰를 포함한 Django의 views.py 파일을 나타냅니다. 각 함수의 내용은 다음과 같습니다:

<div class="content-ad"></div>

- index(request): 이 뷰는 애플리케이션의 홈 페이지를 나타냅니다. `index.html` 템플릿을 렌더링하고 응답으로 반환합니다.
- user_signup(request): 이 뷰는 회원 가입 페이지를 처리합니다. 요청 메서드가 POST인 경우를 확인하여, 이는 폼 제출을 나타냅니다. 그렇다면 UserCreationForm을 사용하여 제출된 폼 데이터를 유효성 검사합니다. 폼이 유효한 경우, 사용자를 저장하고 로그인 페이지로 리디렉션합니다. 요청 메서드가 GET인 경우, UserCreationForm의 새 인스턴스를 만들어 `signup.html` 템플릿을 렌더링하고 폼을 context로 전달합니다.
- user_login(request): 이 뷰는 로그인 페이지를 처리합니다. 요청 메서드가 POST인 경우를 확인하여, 이는 폼 제출을 나타냅니다. LoginForm을 사용하여 제출된 폼 데이터를 유효성 검사합니다. 폼이 유효한 경우, 정제된 데이터에서 사용자 이름과 비밀번호를 검색합니다. 그런 다음 authenticate()를 사용하여 사용자를 인증하고 login()을 사용하여 사용자를 로그인 처리합니다. 사용자가 성공적으로 인증되면 홈 페이지로 리디렉션됩니다. 요청 메서드가 GET인 경우, LoginForm의 새 인스턴스를 만들어 `login.html` 템플릿을 렌더링하고 폼을 context로 전달합니다.
- user_logout(request): 이 뷰는 로그아웃 기능을 처리합니다. Django에서 제공하는 logout() 함수를 호출하여 사용자를 로그아웃하고 로그인 페이지로 리디렉션합니다. 

코드에는 다양한 Django 모듈 및 폼을 위한 import 문 (render, redirect, authenticate, login, logout, UserCreationForm 및 LoginForm)도 포함되어 있습니다. 이러한 import는 뷰의 올바른 작동을 위해 필요합니다.

총론적으로, 이 코드는 Django를 사용하여 사용자 회원 가입, 로그인 및 로그아웃 기능의 기본적인 구현을 보여줍니다. 연결된 폼과 함께 이러한 뷰를 Django 프로젝트에 통합하여 사용자 인증 및 계정 관리를 활성화할 수 있습니다.

<div class="content-ad"></div>

```js
myapp 폴더 안에 forms.py라는 새 파일을 만들고 아래 코드를 작성해주세요:

from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User

class SignupForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'password1', 'password2']

class LoginForm(forms.Form):
    username = forms.CharField()
    password = forms.CharField(widget=forms.PasswordInput)

제공된 코드 스니펫은 Django forms 모듈을 나타내며 SignupForm과 LoginForm 두 가지 폼을 정의합니다. 이러한 폼은 Django 애플리케이션에서 사용자 가입 및 로그인 기능에 사용됩니다.

SignupForm:
```

<div class="content-ad"></div>

- UserCreationForm은 사용자 등록을 위해 특별히 디자인된 내장 Django 폼인 UserCreationForm에서 상속됩니다.
- UserCreationForm은 username, password1, 그리고 password2(비밀번호 확인) 필드를 제공합니다.
- Meta 클래스는 사용할 모델을 지정하는데, 기본 Django User 모델로 django.contrib.auth.models에서 가져옵니다.
- fields 속성은 폼에 포함되어야 하는 필드를 나열하며, 즉 `username`, `password1`, `password2`를 나열합니다.

LoginForm:

- 사용자 로그인을 위해 사용되는 표준 Django 폼입니다.
- 특정 Django 폼 클래스를 상속하지 않습니다.
- forms.CharField() 메서드를 사용하여 'username'과 'password' 두 개의 필드를 정의합니다.
- 'password' 필드는 widget=forms.PasswordInput 인수에 의해 비밀번호 입력 필드로 렌더링됩니다.

이러한 폼은 Django 뷰 내에서 사용자 등록 및 인증 프로세스를 처리하기 위해 사용될 수 있습니다. 적절한 필드와 유효성 검사가 포함된 HTML 폼을 생성하는 편리한 방법을 제공합니다.

<div class="content-ad"></div>

# 7. 템플릿

마이프로젝트에 새로운 폴더 템플릿을 만들고, index.html이라는 새 파일을 생성하고 아래 코드를 작성해 주세요:

```js
{ if request.user.is_authenticated }
  <p>{ request.user.username }</p>
  <a href="{ url 'logout' }">로그아웃</a>
{ else }
  <a href="{ url 'login' }">로그인</a>
  <a href="{ url 'signup' }">가입하기</a>
{ endif }

<h1>환영합니다!</h1>
```

<div class="content-ad"></div>

```js
# 로그인

<form method="POST">
    { csrf_token }
    { form.as_p }
    <button type="submit">로그인</button>
    <a href="{ url 'signup' }">계정이 없으신가요? 가입하기</a>
</form>
```

새로운 signup.html 파일을 생성하고 아래 코드를 작성하세요:

```js
# 가입하기

<form method="POST">
    { csrf_token }
    { form.as_p }
    <button type="submit">가입하기</button>
    <a href="{ url 'login' }">이미 계정이 있으신가요?</a>
</form>
```

# 8. 테스팅 및 실행


<div class="content-ad"></div>

이제 Django Framework을 사용하여 애플리케이션의 기본 구조를 설정했으니, 앱을 테스트하고 실행하는 시간입니다. 다음 단계를 따라주세요:

단계 1: 명령줄 인터페이스 열기

명령줄 인터페이스를 열고 Django 프로젝트의 루트 디렉토리로 이동하세요.

계속 진행하려면 myproject 폴더 내에서 터미널을 열고 다음 명령을 실행하세요:

<div class="content-ad"></div>

```js
python manage.py makemigrations
python manage.py migrate
```

Step 2: 서버 시작하기:

서버를 시작하려면 다음 명령을 명령줄 인터페이스에서 실행하세요:

```js
python manage.py runserver
```

<div class="content-ad"></div>

이 명령을 사용하면 Django 개발 서버가 시작됩니다.

단계 3: 테스트

서버를 실행한 후 http://127.0.0.1:8000/ 에서 프로젝트 인터페이스에 액세스합니다.

어느 브라우저를 열어서 http://127.0.0.1:8000/ URL 로 이동하면 웹 사이트의 홈페이지가 다음과 같이 보입니다:

<div class="content-ad"></div>


![확인 페이지](/assets/img/2024-06-22-DjangoAuthUserSignupandLogin_1.png)

로그인 페이지:

![로그인 페이지](/assets/img/2024-06-22-DjangoAuthUserSignupandLogin_2.png)

가입 페이지:


<div class="content-ad"></div>

![이미지](/assets/img/2024-06-22-DjangoAuthUserSignupandLogin_3.png)

전체 라이브 데모를 확인해보세요:

# 결론

이 블로그 포스트에서는 Django와 HTML 폼을 사용하여 사용자 로그인 및 가입 기능을 구현하는 방법을 살펴보았습니다. Django 프로젝트 설정부터 템플릿 디자인 및 뷰와 폼 구현까지 필요한 단계를 다루었습니다. 제공된 자원과 참고 자료를 따라하면 Django 애플리케이션에서 사용자 인증 프로세스를 더욱 맞춤화하고 향상시킬 수 있습니다.

<div class="content-ad"></div>

웹 애플리케이션의 사용자 인증은 매우 중요한 요소입니다. 사용자 데이터를 보호하기 위해 보안을 우선시하고 최상의 방법을 따르는 것이 중요합니다. Django와 Bootstrap을 사용하면 견고한 보안 조치를 유지하면서도 매끄러운 사용자 경험을 만들 수 있습니다.

코딩 즐기세요!

개발 지식을 공유하는 제 열정을 지원하고자 Buy Me a Coffee로 기부를 부탁드립니다. 여러분의 기부로 저는 가치 있는 콘텐츠와 자료를 만들 수 있습니다. 지원해 주셔서 감사합니다!

이 블로그에서 제시된 정보에 대한 질문이나 의견이 있으면 언제든지 연락해 주세요. 다시 한번 읽어 주셔서 감사합니다!

<div class="content-ad"></div>

# 자료

- Django 프레임워크 문서
- Django AuthenticationForm
- Django UserCreationForm