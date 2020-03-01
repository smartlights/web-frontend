# base image
#FROM arm32v7/node:11.12.0
FROM balenalib/raspberrypi3-64-alpine-node:latest
#FROM amd64/node:11.12.0

# arm virtualization for dockerhub
#COPY qemu-arm-static /usr/bin

RUN [ "cross-build-start" ]
# set working directory
RUN mkdir /app
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV PUBLIC_URL /

# install and cache app dependencies
COPY package.json /app/package.json
RUN npm install

COPY . .

RUN npm install serve env-cmd
RUN npm run build
EXPOSE 3000 
# start app
CMD ["serve", "-s", "build", "-l", "3000"]
RUN [ "cross-build-end" ]
