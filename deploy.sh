docker build -t sarcastron/multi-server:latest -t sarcastron/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sarcastron/multi-client:latest -t sarcastron/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sarcastron/multi-worker:latest -t sarcastron/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sarcastron/multi-server:latest
docker push sarcastron/multi-server:$SHA

docker push sarcastron/multi-client:latest
docker push sarcastron/multi-client:$SHA

docker push sarcastron/multi-worker:latest
docker push sarcastron/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sarcastron/multi-server$SHA
kubectl set image deployments/client-deployment client=sarcastron/multi-client$SHA
kubectl set image deployments/worker-deployment worker=sarcastron/multi-worker$SHA
