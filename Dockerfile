FROM node:13.8

RUN apt update && apt upgrade -y && apt install build-essential git -y

RUN useradd -ms /bin/bash syncuser

USER syncuser
WORKDIR /home/syncuser

RUN git clone -b 3.0 https://github.com/lmontoute/sync

WORKDIR /home/syncuser/sync

RUN npm install

RUN npm run build-server

CMD [ "node", "index.js" ]
