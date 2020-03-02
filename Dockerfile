FROM balenalib/raspberrypi3-64-alpine-node:latest
RUN [ "cross-build-start" ]
RUN mkdir /app
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
ENV PUBLIC_URL /
COPY package.json /app/package.json
RUN npm install
COPY . .
RUN npm install serve env-cmd
RUN npm run build
EXPOSE 3000 
CMD ["serve", "-s", "build", "-l", "3000"]
RUN [ "cross-build-end" ]
