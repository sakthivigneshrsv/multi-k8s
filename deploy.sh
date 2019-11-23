docker build -t sakthivigneshrsv/multi-client:latest -t sakthivigneshrsv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sakthivigneshrsv/multi-server:latest -t sakthivigneshrsv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sakthivigneshrsv/multi-worker:latest -t sakthivigneshrsv/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sakthivigneshrsv/multi-client:latest
docker push sakthivigneshrsv/multi-server:latest
docker push sakthivigneshrsv/multi-worker:latest

docker push sakthivigneshrsv/multi-client:$SHA
docker push sakthivigneshrsv/multi-server:$SHA
docker push sakthivigneshrsv/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sakthivigneshrsv/multi-server:$SHA
kubectl set image deployments/client-deployment client=sakthivigneshrsv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sakthivigneshrsv/multi-worker:$SHA


