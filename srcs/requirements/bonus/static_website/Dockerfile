FROM debian:bullseye

RUN apt update -y

RUN apt install curl -y

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    
RUN apt install nodejs -y

COPY ./tools /home/app

WORKDIR /home/app

RUN npm init -y && npm install express -y

CMD ["node", "index.js"]