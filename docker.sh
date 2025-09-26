docker build -t scotty-app .
docker run -p 3000:3000 --name scotty scotty-app
