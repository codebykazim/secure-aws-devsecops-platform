# Use a lightweight, more recent Node.js image to fix NPM 'tar' vulnerabilities
FROM node:22-alpine

# Patch all OS-level packages (fixes libcrypto3/libssl3 vulnerabilities)
RUN apk update && apk upgrade --no-cache

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install -g npm@latest && npm install

# Copy the rest of the application code
COPY server.js ./

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
