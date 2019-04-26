#/bin/bash
set -e
cwd=`pwd`
base=$cwd/base


cd $base

for component in *; do
    # set some fun variables!    
    kustomization=$base/$component/kustomization.yaml
    out="$base/$component.yaml"

    #sanity check
    if  [ ! -d "$base/$component" ] || [ ! -f "$kustomization" ] ; then
	continue;
    fi

    echo "**************** Building $out  ****************"

    # reset component output yaml w/ header
    cat <<EOF > $out
######################################
#                                    #
#     WARNING: DO NOT EDIT           # 
#                                    #
# this file is auto-getnerated from  #
# the build.sh script                #
#                                    #
######################################
EOF

    # build our component from the kustomization.yaml
    # and append to our output
    cd $base/$component

    kubectl kustomize ./ >> $out
    
       

done
echo "DONE"
