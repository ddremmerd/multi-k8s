docker build -t testecx14/multi-client:latest -t testecx14/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t testecx14/multi-server:latest -t testecx14/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t testecx14/multi-worker:latest -t testecx14/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push testecx14/multi-client:latest
docker push testecx14/multi-server:latest
docker push testecx14/multi-worker:latest

docker push testecx14/multi-client:$SHA
docker push testecx14/multi-server:$SHA
docker push testecx14/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=testecx14/multi-server:$SHA
kubectl set image deployments/client-deployment client=testecx14/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=testecx14/multi-worker:$SHA

