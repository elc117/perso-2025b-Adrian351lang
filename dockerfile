FROM haskell:latest

WORKDIR /app

RUN cabal update && cabal install --lib scotty text

COPY . .

EXPOSE 3000

CMD ["make"]
