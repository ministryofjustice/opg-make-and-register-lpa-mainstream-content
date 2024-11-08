FROM node:20-alpine AS fetched-repo

WORKDIR /app

RUN apk add git && git clone https://github.com/gaynorc75/register-lpa-prototype.git && ls

FROM node:20-alpine AS build

RUN addgroup -g 1017 -S appgroup \
  && adduser -u 1017 -S appuser -G appgroup

WORKDIR /app

COPY --from=fetched-repo app/register-lpa-prototype/package*.json ./

RUN npm install

COPY --from=fetched-repo app/register-lpa-prototype/app ./app
COPY --link ./start.sh ./app/start.sh

RUN chown -R appuser:appgroup /app

USER 1017

EXPOSE 3000

CMD ["./app/start.sh"]
