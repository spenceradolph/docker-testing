# Stage 1 = dev environment
#######################################################
FROM node:17 AS dev_stage
WORKDIR /app

# Stage 2 = install
#######################################################
FROM dev_stage AS install_stage
COPY . .
RUN npm install

# Stage 3 = build compiled/production version
#######################################################
FROM install_stage AS builder_stage
RUN npm run build

# Stage 4 = run (slim)
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
