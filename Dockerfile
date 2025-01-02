FROM node:20-alpine AS fetched-repo

WORKDIR /app

RUN apk add --no-cache git=2.45.2-r0
ADD https://api.github.com/repos/gaynorc75/register-lpa-prototype/git/refs/heads/main version.json
RUN git clone -b main https://github.com/gaynorc75/register-lpa-prototype.git

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

COPY scripts/docker_hardening/alpine_image_hardening.sh /harden.sh

RUN /harden.sh && rm /harden.sh

CMD ["./app/start.sh"]
