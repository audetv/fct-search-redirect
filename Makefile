deploy:
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'docker network create --driver=overlay traefik-public || true'
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'rm -rf audetv-redirect_${BUILD_NUMBER} && mkdir audetv-redirect_${BUILD_NUMBER}'
	scp -o StrictHostKeyChecking=no -P ${PORT} docker-compose-production.yml deploy@${HOST}:audetv-redirect_${BUILD_NUMBER}/docker-compose.yml
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'cd audetv-redirect_${BUILD_NUMBER} && docker stack deploy -c docker-compose.yml audetv-redirect'

rollback:
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'cd audetv-redirect_${BUILD_NUMBER} && docker stack deploy -c docker-compose.yml audetv-redirect'
