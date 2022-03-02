# Stage 1 = dev environment / install
#######################################################
FROM node:17 AS dev_stage
WORKDIR /app
COPY . .
RUN npm install

# Stage 2 = build compiled/production version
#######################################################
FROM dev_stage AS builder_stage
RUN npm run build

# Stage 3 = run (slim)
#######################################################
FROM node:17-alpine
WORKDIR /app

ENV NODE_ENV=production
COPY ./package.json ./
COPY ./packages/web/package.json ./packages/web/package.json
COPY ./packages/server/package.json ./packages/server/package.json
RUN npm install
COPY --from=builder_stage /app/dist ./dist

ENV PORT=5000
EXPOSE 5000
USER node
ENTRYPOINT ["npm", "start"]
