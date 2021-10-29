FROM node:16-alpine

WORKDIR /frontend

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

RUN apk add --no-cache git
RUN npm install npm@latest -g
RUN npm install npm@latest -g
RUN npm install

COPY . .

CMD ["npm", "run", "serve"]

## In production environment use commands bellow 
#RUN npm run build
#EXPOSE 8080
#CMD [ "http-server", "dist" ]
