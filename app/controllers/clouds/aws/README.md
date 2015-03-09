# AWS Commands
##Usage: https://github.com/jakubroztocil/httpie
##ELB -
###Create:
```
http POST http://localhost:8888/api/clouds/aws/elb X-Api-Version:1.0 name='mylb' region='us-west-1' zones:='["us-west-1b"]' listeners:='[{ "Protocol":"HTTP", "LoadBalancerPort":80, "InstancePort":8080, "InstanceProtocol":"HTTP"}]' 
```
###Delete: 
http DELETE http://localhost:8888/api/clouds/aws/elb X-Api-Version:1.0 name='mylb' region='us-west-1'
##Tag -
###Create:
http POST http://localhost:8888/api/clouds/aws/tag X-Api-Version:1.0 region='us-west-1' resource_id:='["vol-123456"]' tags:='{"example-key":"example-value"}'
###Delete:
http DELETE http://localhost:8888/api/clouds/aws/tag X-Api-Version:1.0 region='us-west-1' resource_id:='["vol-123456"]' tags:='{"example-key":"example-value"}'
###Get:
http GET http://localhost:8888/api/clouds/aws/tag?region='us-west-1' X-Api-Version:1.0
