helm create $target
cd $target && helm lint && cd ..
helm package $target --debug
helm install "${target}-${version}.tgz"
helm ls
kubectl get deployments
