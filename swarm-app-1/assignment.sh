# node1
docker swarm init --advertise-addr x.x.x.x
docker swarm join-token worker

# node2 and node3 paste ^^

# node1
docker service create -d --name vote -p 80:80 --replicas 3 --network frontend dockersamples/examplevotingapp_vote:before
docker service create -d --name redis --network frontend --replicas 1 redis:3.2
docker service create -d --name worker --network frontend --network backend --replicas 1 dockersamples/examplevotingapp_worker
docker service create -d --name db --mount type=volume,source=db-data,target=/var/lib/postgresql/data --network backend --replicas 1 postgres:9.4
docker service create -d --name result --network backend -p 5001:80 --replicas 1 dockersamples/examplevotingapp_result:before