#!/usr/bin/env bash

# Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
SELECTORS=$1

NODES=$(kubectl get nodes --selector "$SELECTORS" --output jsonpath='{.items[*].metadata.name}')

for node in $NODES
do
    kubectl get pods --all-namespaces --field-selector spec.nodeName=$node
done
