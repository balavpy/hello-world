#/bin/bash
http_url=`kubectl get svc  webapp  | cut -d' ' -f10 | tail -1`
httpstatus=`curl -s -o /dev/null -w "%{http_code}" ${http_url}:8080/webapp/`
if [ $httpstatus == "200" ]; then
  echo "http status is  '${httpstatus}'- Application is Up & Running"
else
  echo "http status is  '${httpstatus}' "
fi;
