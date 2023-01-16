#!/usr/bin/env bash

# Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
SELECTORS=$1

NODES=$(kubectl get nodes --selector "$SELECTORS" --output jsonpath='{.items[*].metadata.name}')
echo "======================="
echo "Nodes martching labels: $SELECTORS"
echo "======================="
echo $NODES

echo -e "\n"

for NODE in $NODES
do
    echo "======================"
    echo "Getting pods for node: $NODE"
    echo "======================"
    kubectl get pods --all-namespaces --field-selector spec.nodeName=$NODE
done
