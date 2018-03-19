oc get is,cm,pvc,sa,bc,dc,svc,route --output=jsonpath='{range .items[*]}{.kind}{"\t"}{.metadata.name}{"\t"}{.metadata.labels}{"\n"}{end}'
