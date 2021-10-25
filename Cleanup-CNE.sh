helm uninstall -n brm-demo-dev-apps brm12-ocomc
helm uninstall -n brm-demo-dev-apps brm12-ece
helm uninstall -n brm-demo-dev-apps kafka
helm uninstall -n brm-demo-dev-apps brm12-core
helm uninstall -n brm-demo-dev-apps brm12-op-job
helm uninstall -n brm-demo-dev-apps nfs

helm uninstall -n weblogic-operator weblogic-operator
helm uninstall -n monitoring prometheus-operator
helm uninstall -n brm-demo-dev-apps efk
helm uninstall -n traefik traefik
kubectl delete job ece-persistence-job -n brm-demo-dev-apps
kubectl delete namespace brm-demo-dev-db
kubectl delete namespace brm-demo-dev-apps
kubectl delete namespace weblogic-operator
kubectl delete namespace monitoring
kubectl delete namespace logging
kubectl delete namespace traefik
kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com
pvc=`kubectl get pv,pvc,sc | grep pvc- |grep Released | awk '{print $1}'`
for file in $pvc;
 do
  echo "in$file"
  kubectl delete $file;
 done;
rm -rf /app/jenkins/workspaces/brm-demo-dev-apps
ssh -i .ssh/id_rsa jmngdrpv019794 -t ' sudo umount -lf /export/brm-demo-dev-apps && sudo rmdir  /export/brm-demo-dev-apps'
ssh -i .ssh/id_rsa jmngdrpv019793 -t 'rm -r /data/brm*'
