# beckyshaw/easy-ccloud
<a href='https://ko-fi.com/rooshaw' target='_blank'><img height='35' style='border:0px;height:46px;' src='https://az743702.vo.msecnd.net/cdn/kofi3.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' />

Most of the scripts here are dirty and untidy but functional all the same. They're mostly for my own purpose and development but if you're here then i will have shared access for something at some point or by the power of the internet, here you are. 

## Quick tips
Set the below aliases for quick running of scripts. All commands must be run from the 'easy-ccloud/ccloud' directory

```
  alias nonprod-get-secrets="sh nonprod/tasks/get-secrets.sh"
  alias nonprod-get-api="sh nonprod/tasks/api-csv.sh"
  alias nonprod-delete-secrets="sh nonprod/tasks/delete-secrets.sh"
  alias prod-get-secrets="sh prod/tasks/get-secrets.sh"
  alias prod-get-api="sh prod/tasks/api-csv.sh"
  alias prod-delete-secrets="sh prod/tasks/delete-secrets.sh"
```

## ccloud Repo
Most of this is for Confluent Cloud tasks and Kafka tasks. There are multiple scripts for managing topics and API keys withing Confluent Cloud.
Before this will work please ensure you are updating the variable in the /ccloud/vars files for stg and prod. 
To find your Kubernetes context name type " kubectl config get-contexts" and change this to the corresponding name


## Discussion
If you see something here that you think can be improved or done in a mroe efficient way please drop a thread in the discussions page. Also open to hear ideas for future projects.
Leave any threads here if you need help with something 

