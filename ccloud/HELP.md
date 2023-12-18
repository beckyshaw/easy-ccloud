:::    ::: :::::::::: :::        :::::::::        ::::::::  :::    ::: ::::::::::: :::::::::  :::::::::: 
:+:    :+: :+:        :+:        :+:    :+:      :+:    :+: :+:    :+:     :+:     :+:    :+: :+:        
+:+    +:+ +:+        +:+        +:+    +:+      +:+        +:+    +:+     +:+     +:+    +:+ +:+        
+#++:++#++ +#++:++#   +#+        +#++:++#+       :#:        +#+    +:+     +#+     +#+    +:+ +#++:++#   
+#+    +#+ +#+        +#+        +#+             +#+   +#+# +#+    +#+     +#+     +#+    +#+ +#+        
#+#    #+# #+#        #+#        #+#             #+#    #+# #+#    #+#     #+#     #+#    #+# #+#        
###    ### ########## ########## ###              ########   ########  ########### #########  ########## 


# Confluent Cloud
All commands must be run from the '/ccloud/kube' folder else it will not work

## Environment:
Set the following aliases to make deployment faster
```
alias nonnonprod-get-secrets="sh nonprod/tasks/get-secrets.sh"
alias nonprod-get-api="sh nonprod/tasks/api-csv.sh"
alias nonprod-delete-secrets="sh nonprod/tasks/delete-secrets.sh"

alias prod-get-secrets="sh prod/tasks/get-secrets.sh"
alias prod-get-api="sh prod/tasks/api-csv.sh"
alias prod-delete-secrets="sh prod/tasks/delete-secrets.sh"
```



## Schema Validation
Template
```
    - name: topic-name
      partitions: 1
      replication_factor: 3
      configs:
        cleanup.policy: "compact"
        retention.ms: "86400000" # 1 day
        confluent.value.schema.validation=true
        confluent.key.schema.validation=true
```





## KNOWN ISSUES:
### Error 1
If you are seeing the error : 
        E0920 --   70799 memcache.go:265 -- couldn't get current server API group list: the server has asked for the client to provide credentials
You need to run k9s and select a pod to log in with

### Error 2
        error: Unexpected args: []   
This has been showing at the start of script and I'm not sure why. It doesnt seem to affect anything and if i can figure out why then I will fix but for now just ignore it

### Error 3
        zsh: permission denied: nonprod/nonprod-validation.sh
You need to put 'sh' in front to run the shell script

 ,_     _
 |\\_,-~/
 / _  _ |    ,--.
(  @  @ )   / ,-'
 \  _T_/-._( (
 /         `. \
|         _  \ |
 \ \ ,  /      |
  || |-_\__   /
 ((_/`(____,-' fin