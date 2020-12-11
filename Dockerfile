# builder stage # 빌드 파일 생성하는 단계, 빌드 후 WORKDIR/build 로 들어감

# base image(OS), node는 npm이 설치되어 있는 이미지 중 하나
# 다음 FROM 전까지는 모두 builder stage 라는 것을 명시
FROM node:alpine as builder 

# workdir 없으면 / 에 업로드
WORKDIR '/usr/src/app'

# 소스코드만 변경 시 npm install 로 종속성을 또 다운받지 않도록 package.json만 따로 copy
COPY package.json ./

# 추가적으로 필요한 파일들
RUN npm install

# 컨테이너에 넣어야할 파일(모든 소스코드, 설정), 컨테이너 내 목적지
COPY ./ ./

# 컨테이너 시작시 실행 될 명령어, 1회만 쓸 수 있음
# react run
RUN npm run build


# run stage
# nginx 설치된 이미지
FROM nginx 
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# /usr/src/app/build 파일이 builder 에서 온다는 것을 명시
# /usr/share/nginx/html => nginx 웹 루트 디렉터리
