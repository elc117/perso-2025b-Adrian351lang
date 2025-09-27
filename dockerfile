FROM haskell:latest

WORKDIR /app

RUN cabal update && cabal install --lib scotty text

# nota: copy deve ficar depois de cabal, para não ter que rebaixar as bibliotecas toda vez
COPY . .

EXPOSE 3000

CMD ["make"]
