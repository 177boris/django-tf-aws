APP_NAME = relearn-sns
TAG = DEV

AWS_ACCOUNT_ID = 216761891772
AWS_REGION = eu-west-2
AWS_ECR_REPO = $(APP_NAME)

.PHONY 	: docker/build docker/push


docker/build : 
	docker build -t $(APP_NAME):$(TAG) . 

docker/push : docker/build
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
	docker tag $(APP_NAME):$(TAG) $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(AWS_ECR_REPO):$(TAG)
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION)amazonaws.com/$(AWS_ECR_REPO):$(TAG)
