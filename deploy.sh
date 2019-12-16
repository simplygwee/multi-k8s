docker build -t simplygwee/multi-client:latest -t simplygwee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t simplygwee/multi-server:latest -t simplygwee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t simplygwee/multi-worker:latest -t simplygwee/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push simplygwee/multi-client:latest
docker push simplygwee/multi-server:latest
docker push simplygwee/multi-worker:latest
docker push simplygwee/multi-client:$SHA
docker push simplygwee/multi-server:$SHA
docker push simplygwee/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=simplygwee/multi-server:$SHA
kubectl set image deployments/client-deployment client=simplygwee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=simplygwee/multi-worker:$SHA