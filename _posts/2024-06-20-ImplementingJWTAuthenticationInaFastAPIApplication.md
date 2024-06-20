---
title: "빠른 FastAPI 애플리케이션에서 JWT 인증 구현하기"
description: ""
coverImage: "/assets/img/2024-06-20-ImplementingJWTAuthenticationInaFastAPIApplication_0.png"
date: 2024-06-20 14:08
ogImage: 
  url: /assets/img/2024-06-20-ImplementingJWTAuthenticationInaFastAPIApplication_0.png
tag: Tech
originalTitle: "Implementing JWT Authentication In a FastAPI Application"
link: "https://medium.com/@rajansahu713/implementing-jwt-authentication-in-a-fastapi-application-0c9c012bdfdc"
---


이 블로그 포스트에서는 FastAPI 애플리케이션에서 JWT (JSON Web Token) 인증을 구현하는 방법을 안내하겠습니다. JWT는 두 당사자 간에 주장을 나타내는 컴팩트하고 URL-안전한 수단으로, 보안 인증에 일반적으로 사용됩니다.

![이미지](/assets/img/2024-06-20-ImplementingJWTAuthenticationInaFastAPIApplication_0.png)

## JWT란 무엇인가요?

JWT는 JSON Web Token의 약자입니다. 일부 주장을 나타내는 토큰을 생성하기 위한 표준입니다. 이러한 토큰들은 비밀 키 또는 공개/개인 키 쌍으로 서명됩니다. 다음은 JWT가 작동하는 간단한 설명입니다:

<div class="content-ad"></div>

- 헤더: 일반적으로 토큰 유형 (JWT)과 서명 알고리즘 (예: HMAC SHA256 또는 RSA)으로 구성됩니다.

```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

- 페이로드: 클레임은 개체(일반적으로 사용자)에 관한 문장과 추가 데이터입니다.

```json
{
  "username": "rajan",
  "email": "rajan12@rajan.com"
}
```

<div class="content-ad"></div>

- 서명: 서명 부분을 만들려면 인코딩된 헤더, 인코딩된 페이로드, 비밀키 및 헤더에서 지정한 알고리즘을 가져 와야 합니다.

```js
# secret id
ABjhjdsjfsh234fjhuih324$jihdfdshkgsog
```

## JWT의 장점:

- 간결함: JWT는 간결하며 URL, POST 매개변수 또는 HTTP 헤더 안에 전송할 수 있어 모바일 애플리케이션에 적합합니다.
- 자체 포함: 페이로드에는 인증에 필요한 모든 정보가 포함되어 있어 여러 개의 데이터베이스 쿼리가 필요하지 않습니다.

<div class="content-ad"></div>

## FastAPI에서의 단계별 구현

## 단계 1: 의존성 설정

먼저, FastAPI와 관련 의존성이 설치되어 있는지 확인하세요:

```js
pip install fastapi 
pip install passlib 
pip install python-jose
```

<div class="content-ad"></div>

## 단계 2: 모델 및 스키마 정의

사용자 모델과 요청/응답 스키마를 정의할 것입니다.

## models.py

```python
# models.py

from pydantic import BaseModel
from typing import List

class User(BaseModel):
    username: str
    email: str
    hashed_password: str

# 메모리 내 "데이터베이스"
fake_users_db: List[User] = []
blocklist_token = []
```

<div class="content-ad"></div>

이 블로그에서는 데이터를 메모리에 저장합니다. 위의 코드 스니펫에서 볼 수 있듯이, fake_user_db를 사용하여 사용자 세부 정보를 저장하고, blocklist_token을 사용하여 차단된 토큰을 저장합니다.

## schemas.py

```js
from pydantic import BaseModel, EmailStr

class UserCreate(BaseModel):
    username: str
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    username: str
    email: str

class Token(BaseModel):
    access_token: str
    token_type: str
```

이 스키마 모델은 사용자 요청 본문을 유효성 검사하는 데 사용되며, 적절한 형식으로 응답을 전송합니다.

<div class="content-ad"></div>

## 단계 3: 설정 상수

## constants.py

```js
SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
```

- 이 파일은 주로 애플리케이션에 상수를 정의하는 데 사용됩니다.

<div class="content-ad"></div>

## 단계 4: 인증 핸들러

이것은 우리의 JWT 인증의 핵심입니다. 이는 비밀번호 해싱, 토큰 생성 및 사용자 인증을 처리합니다.

## auth.py

```python
from fastapi import HTTPException, status
from jose import jwt, JWTError
from passlib.context import CryptContext
from datetime import datetime, timedelta
from typing import Optional
from models import fake_users_db, blocklist_token
from constants import SECRET_KEY, ALGORITHM
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from fastapi import Security

class AuthHandler:
    security = HTTPBearer()
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

    async def verify_password(self, plain_password, hashed_password):
        return self.pwd_context.verify(plain_password, hashed_password)

    async def get_password_hash(self, password):
        return self.pwd_context.hash(password)

    async def create_access_token(self, data: dict, expires_delta: Optional[timedelta] = None):
        to_encode = data.copy()
        if expires_delta:
            expire = datetime.utcnow() + expires_delta
        else:
            expire = datetime.utcnow() + timedelta(minutes=15)
        to_encode.update({"exp": expire})
        encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
        return encoded_jwt

    async def get_user(self, username: str):
        user = next((user for user in fake_users_db if user.username == username), None)
        return user

    async def authenticate_user(self, username: str, password: str):
        user = await self.get_user(username)
        if not user:
            return False
        if not await self.verify_password(password, user.hashed_password):
            return False
        return user
    
    async def blocklist_token(self, token):
        blocklist_token.append(token)

    async def istokenblock(self, token):
        return token in blocklist_token

    async def auth_wrapper(self, auth: HTTPAuthorizationCredentials = Security(security)):
        token = auth.credentials
        if not token or await self.istokenblock(token):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Not authenticated",
                headers={"WWW-Authenticate": "Bearer"},
            )
        try:
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            username: str = payload.get("sub")
            if username is None:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail="Not authenticated",
                    headers={"WWW-Authenticate": "Bearer"},
                )
        except JWTError:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Not authenticated",
                headers={"WWW-Authenticate": "Bearer"},
            )
        user = await self.get_user(username)
        if user is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Not authenticated",
                headers={"WWW-Authenticate": "Bearer"},
            )
        return user
```

<div class="content-ad"></div>

- 이곳은 인증 애플리케이션의 핵심입니다. 여기서 verify_password, authenticate_user, blocklist_token 등과 같은 모든 중요한 기능을 정의해야 합니다.

## 단계 5: 사용자 등록 및 토큰 생성

## controller.py

```js
from schemas import UserCreate, UserResponse, Token
from fastapi import APIRouter
from auth import AuthHandler
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from datetime import timedelta
from models import User, fake_users_db
from constants import ACCESS_TOKEN_EXPIRE_MINUTES
from fastapi.security import HTTPAuthorizationCredentials
from fastapi import Security


auth_router = APIRouter()
auth_handle = AuthHandler()

@auth_router.post("/register", response_model=UserResponse)
async def register_user(user: UserCreate):
    if await auth_handle.get_user(user.username):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="이미 등록된 사용자명입니다.",
        )
    hashed_password = await auth_handle.get_password_hash(user.password)
    new_user = User(username=user.username, email=user.email, hashed_password=hashed_password)
    fake_users_db.append(new_user)
    return new_user

@auth_router.post("/token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    user = await auth_handle.authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="잘못된 사용자명 또는 비밀번호입니다.",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = await auth_handle.create_access_token(
        data={"sub": user.username}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

@auth_router.post("/logout")
async def logout_access_token(auth: HTTPAuthorizationCredentials = Security(auth_handle.security)):
    await auth_handle.blocklist_token(auth.credentials)
    return {"message": "로그아웃 되었습니다."}
```

<div class="content-ad"></div>

여기에서는 사용자를 등록하고 로그인하며 토큰을 생성하는 데 사용되는 모든 컨트롤러를 정의합니다.

## 단계 6: FastAPI와 통합하기

마지막으로, 모든 것을 주 애플리케이션에 통합하세요.

## main.py

<div class="content-ad"></div>

```python
from fastapi import FastAPI, Depends
from controller import auth_router
from models import User
from auth import AuthHandler

app = FastAPI()
auth_handler = AuthHandler()
app.include_router(auth_router, prefix="/auth", tags=["Auth"])

@app.get("/auth-test")
async def read_users_me(current_user: User = Depends(auth_handler.auth_wrapper)):
    return current_user
```

JWT 인증을 테스트하기 위한 라우트를 만들었습니다.

여기 GitHub 링크 있어요!!

## 결론


<div class="content-ad"></div>

FastAPI 애플리케이션에 JWT 인증을 설정했군요. 이 설정에는 사용자 등록, JWT 토큰 생성을 위한 로그인 및 보호된 경로를 위한 토큰 확인이 포함되어 있어요. JWT는 인증된 사용자만 특정 엔드포인트에 접근할 수 있도록 보장하여 API를 안전하고 사용자 친화적으로 만들어줍니다.

## 참고:

- https://fastapi.tiangolo.com/

독서해 주셔서 감사합니다. 만약 잘못된 부분이나 더 좋은 방법을 알고 계시다면 아래 댓글에 알려주세요.

<div class="content-ad"></div>

만약 이 게시물이 마음에 든다면 아래의 👏 버튼을 눌러주세요. 다른 사람들이 유용하게 활용할 수 있도록 도와주세요. 또한 GitHub에서 저를 팔로우하고 Linkedin에서 저와 연결할 수 있습니다.