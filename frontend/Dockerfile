# Choose the Image which has Node installed already
FROM node:16-alpine

# Make the 'frontend' folder the current working directory
WORKDIR /frontend

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

# Install system dependencies
RUN apk add --no-cache git

#####
# Installing latest version of node doesn't mean it provide latest version of npm package.
# Then you have to run npm install npm@latest -g twice as below
#####
RUN npm install npm@latest -g
RUN npm install npm@latest -g

# Install project dependencies
# If you are building your code for production
# RUN npm ci --only=production
# RUN npm install --production
RUN npm install

COPY . .

EXPOSE 8080

HEALTHCHECK --interval=1m --timeout=30s --retries=3 CMD curl --fail http://localhost:8080 || exit 1

CMD ["npm", "run", "serve"]