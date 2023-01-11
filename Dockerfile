FROM node:12 as node-build

WORKDIR /app

COPY ./ /app

RUN npm install

RUN npm run build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=node-build /app/dist/cprs-ui /usr/share/nginx/html/cprs
RUN chmod -R 0755 /usr/share/nginx/html/cprs/assets
RUN chmod 0755 /usr/share/nginx/html/cprs/favicon.ico

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 7004
