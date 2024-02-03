docker build -t burnsmarty/multi-client:latest -t burnsmarty/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t burnsmarty/multi-server:latest -t burnsmarty/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t burnsmarty/multi-worker:latest -t burnsmarty/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push burnsmarty/multi-client:latest
docker push burnsmarty/multi-server:latest
docker push burnsmarty/multi-worker:latest
docker push burnsmarty/multi-client:$SHA
docker push burnsmarty/multi-server:$SHA
docker push burnsmarty/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=burnsmarty/multi-server:$SHA
kubectl set image deployments/client-deployment client=burnsmarty/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=burnsmarty/multi-worker:$SHA

