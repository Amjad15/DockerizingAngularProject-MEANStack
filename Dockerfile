FROM node:14.17.3 AS ui-build
WORKDIR /usr/src/app
COPY testApp/ ./testApp/
RUN cd testApp && npm install @angular/cli && npm install && npm install express && npm i body-parser && npm run build

FROM node:10 AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/testApp/dist ./testApp/dist
COPY package*.json ./
RUN npm install && npm install express && npm i body-parser
COPY server.js .

EXPOSE 3080

CMD ["node", "server.js"]

