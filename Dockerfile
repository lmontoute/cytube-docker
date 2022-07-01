FROM node:13.8

RUN apt update && apt upgrade -y && apt install build-essential git -y

RUN useradd -ms /bin/bash syncuser

USER syncuser
WORKDIR /home/syncuser

# https://stackoverflow.com/a/58801213
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
COPY --chown=syncuser:syncuser ./sync/ /home/syncuser/sync/

WORKDIR /home/syncuser/sync

RUN rm -r node_modules
RUN rm -r .git
RUN ls -al
RUN npm install

RUN npm run build-server

CMD [ "node", "index.js" ]
