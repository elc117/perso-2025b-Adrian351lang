FROM haskell:latest

WORKDIR /app

COPY . .

RUN cabal update && cabal install --lib scotty text

EXPOSE 3000

CMD ["make"]
